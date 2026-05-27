---
title: "Shipping Your Machine: Building a Container in 50 Lines of Code (Part 2)"
date: 2026-05-26 15:03:07 +0000
permalink: /shipping-your-machine-building-a-container-in-50-lines-of-code-part-2-4cm4
header:
  teaser: /assets/images/posts/2026-05-26-shipping-your-machine-building-a-container-in-50-lines-of-code-part-2-4cm4-cover.jpg
tags:
  - go
  - containers
  - beginners
  - docker
---

## Welcome Back to the Jailhouse

In [Part 1 of this series](/shipping-your-machine-building-a-container-in-60-lines-of-code-part-1-14ma), we built the foundation of our container using Go. We successfully used the `CLONE_NEWUTS` namespace and process forking to isolate our container's hostname from the host machine. 

But we still have a massive security flaw. Right now, if we drop into our container's bash shell, we can still see all of the host's files. We could easily `cd` straight out of our "isolated" environment and mess with the host machine. 

Let's lock it down.

### `chroot` to Jail

Linux has a wonderful system call called `chroot` (short for "change root"). It lets us change the root directory (`/`) for a given process. As far as the process is concerned, the directory we point `chroot` to *is the entire universe*. Anything outside of it simply doesn't exist.

Let's update our `child()` function to set the root directory to our current working directory:

```go
func child() {
	fmt.Printf("Running in new child process %v \n", os.Args[2:])
	
	must(syscall.Sethostname([]byte("container")))
	
	// Get current directory and lock the process inside it
	pwd, err := os.Getwd()
	must(err)

	must(syscall.Chroot(pwd))
	// chroot changes the root, but doesn't automatically move us there. 
	// We must explicitly change our working directory to the new root!
	must(os.Chdir("/"))
	
	cmd := exec.Command(os.Args[2], os.Args[3:]...)
	cmd.Stdin = os.Stdin
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	
	must(cmd.Run())
}

```

Run `sudo go run main.go run /bin/bash`.

**Crash!** 


```bash
panic: fork/exec /bin/bash: no such file or directory
```
What happened?

We just told our process that our current directory is the entire universe. So, when we ask `exec.Command` to run `/bin/bash`, it isn't looking at your computer's actual hard drive anymore. It is looking inside your project folder for a directory called `bin` containing an executable called `bash`.

Because our current directory doesn't have those, it fails! We need an actual root filesystem to provide the basic binaries our shell expects.

*(Note: Production container runtimes like runC actually use a more advanced system call called `pivot_root` for better security, but `chroot` is perfect for understanding the core concept!).*

### The Image

To fix this, we need to provide an actual root filesystem that contains the basic folders and binaries (like /bin/bash) that our shell expects.

You can grab a basic Ubuntu root filesystem yourself using Docker. Open a new terminal tab and run these exact commands in your project directory:

```bash
# Use docker to start a Ubuntu container and then export its filesystem to a compressed file called ubuntu.tar
docker export $(docker create ubuntu) > ubuntu.tar

# Create a directory called ubuntu-rootfs and unzip your tar file into it
mkdir ubuntu-rootfs
tar -xf ubuntu.tar -C ubuntu-rootfs
```
This creates a folder called `ubuntu-rootfs` containing a complete, brand-new Ubuntu file system.

Assuming you have that folder in your project directory, let's change our `chroot` call to point to it as follows:

```go
	must(syscall.Chroot(filepath.Join(pwd, "ubuntu-rootfs")))
	must(os.Chdir("/"))

```

Now, when we run `sudo go run main.go run /bin/bash`, everything works perfectly! 

You can run `ls /` and you will only see the files inside your `ubuntu-rootfs` directory. Try running `cd ..` to escape, and you will find yourself in the exact same directory as before. You cannot access the host machine at all.

### PIDs and /proc

We're ready for the next step. If you remember, when we ran `docker run -it ubuntu /bin/bash` back in the beginning of Part 1, one of the ways we could tell we were in an isolated container was by running `ps aux` and observing only two processes running with very low PIDs.

Let's try to replicate that. While inside our new container, try running `ps aux` to view the running processes.

It breaks with an error: 

```bash
Error, do this: mount -t proc proc /proc
```

The `ps` command works by reading the `/proc` directory, which is a special virtual filesystem in Linux that contains live data about running processes. Our isolated root filesystem has an empty `/proc` folder, and the operating system hasn't been told to attach the live process data to it. Because it's empty, `ps` fails!

To fix this, we need to do two things:

1. Give our container its own isolated Process IDs (PIDs) using namespaces.
2. Mount the `proc` filesystem so commands like `ps` can read it.

First, update the `SysProcAttr` in the `run()` function to include the PID and Mount namespaces. (Note: `CLONE_NEWNS` stands for "New Namespace", but it specifically refers to the Mount namespace! It just happens to be the first namespace added to the Linux kernel and back then no one thought they might end up needing more so they just called it "namespace" 🤷).

```go
	cmd.SysProcAttr = &syscall.SysProcAttr{
		Cloneflags: syscall.CLONE_NEWUTS | syscall.CLONE_NEWPID | syscall.CLONE_NEWNS,
	}

```

Next, mount the `proc` directory inside our `child()` function, right after we `chroot`. We will also use Go's `defer` keyword to ensure we unmount it and clean up after ourselves when the function exits:

```go
	must(syscall.Chroot(filepath.Join(pwd, "ubuntu-rootfs")))
	must(os.Chdir("/"))
	
	// Mount the proc filesystem
	must(syscall.Mount("proc", "proc", "proc", 0, ""))
	// Clean up after ourselves when the function exits
	defer syscall.Unmount("proc", 0)
```

Now, run your container and type `ps aux`. You'll see only three processes running: `exe` (our Go program) running as PID 1, `bash` running as PID 2, and the `ps` command we just ran!

### Cgroups (Keeping it Civil)

We have our invisibility cloak (Namespaces) and our isolated universe (`chroot`). But what happens if we write an infinite `while` loop inside our container that eats up all the CPU and memory?

It would completely crash the host machine!

To prevent our container from using up all of our resources, Linux uses **cgroups** (Control Groups). Cgroups act as the bouncer, ensuring no single container uses more than its fair share of resources.

To set up a cgroup, we can lean on a famous Linux philosophy: "Everything is a file." This means we can configure the kernel's resource limits by creating specific directories and writing text into special files.

Let's add a quick helper function to our `main.go` file to limit the maximum number of processes our container is allowed to spawn to 20:

```go
func cg() {
	cgroups := "/sys/fs/cgroup/"
	pids := filepath.Join(cgroups, "pids")
	
	// 1. Create a new cgroup for our container
	containerCgroup := filepath.Join(pids, "my-container")
	os.Mkdir(containerCgroup, 0755)
	
	// 2. Write the limit into the cgroup file (max 20 processes)
	must(os.WriteFile(filepath.Join(containerCgroup, "pids.max"), []byte("20"), 0700))
	
	// 3. Add our current process to this cgroup
	must(os.WriteFile(filepath.Join(containerCgroup, "cgroup.procs"), []byte(strconv.Itoa(os.Getpid())), 0700))
}
```

Let's break down what this function is doing:

1. **Create the group:** By making a new directory inside `/sys/fs/cgroup/pids`, the Linux kernel automatically creates a new Control Group for us.

2. **Set the rule:** Inside that new directory, Linux automatically generates a file called `pids.max`. We open that file and write the text `"20"` into it. This establishes a rule that our process will only be allowed to run 20 sub-processes.

3. **Enforce the rule:** Linux also generates a file called `cgroup.procs`. We get our Go program's current Process ID (`os.Getpid()`) and write it into this file. This tells the kernel, *"Hey, apply the rules of this folder to me!"*

Finally, let's call this function inside our `run()` function, right before we execute our child process:

```go
func run() {
	fmt.Printf("Running %v \n", os.Args[2:])
	
	args := append([]string{"child"}, os.Args[2:]...)
	cmd := exec.Command("/proc/self/exe", args...)
	
	cmd.Stdin = os.Stdin
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	
	cmd.SysProcAttr = &syscall.SysProcAttr{
		Cloneflags: syscall.CLONE_NEWUTS | syscall.CLONE_NEWPID | syscall.CLONE_NEWNS,
	}
	
	// Set up our resource limits!
	cg()
	
	must(cmd.Run())
}
```

And just like that, our container is officially resource-limited! Because cgroups inherit down to child processes, everything that runs inside our container is bound by this rule. If a malicious script inside tries to execute a "fork-bomb" (a script that endlessly copies itself to freeze the computer), the kernel will step in and aggressively kill it the second it hits 20 processes.

### The Reveal

If you put all of this together, we just built Docker from scratch in about 50 lines of code.

Containers aren't magic. They aren't heavyweight VMs. They are simply standard Linux processes wrapped in namespaces, jailed in a specific directory, and policed by cgroups.

In fact, you don't even need Go to do this. You can trigger the exact same isolation using a single line of bash:

```bash
sudo unshare --uts --pid --mount --fork --root=/home/ubuntu-rootfs --mount-proc /bin/bash

```

And there you have it! The next time someone says "it works on my machine," you know exactly what it takes to ship their machine to production.

