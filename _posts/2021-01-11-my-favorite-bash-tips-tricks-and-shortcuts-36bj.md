---
title: "My Favorite Bash Tips, Tricks, and Shortcuts"
date: 2021-01-11 22:23:39 +0000
permalink: /my-favorite-bash-tips-tricks-and-shortcuts-36bj
tags:
  - command-line
  - productivity
  - learning
  - tutorial
series: "Tips and Tricks"
---

If you're on DEV, chances are you spend at least **some** time in the terminal, maybe even a **lot** of time.

Over the years, I've picked up a number of tips and tricks from fellow developers. Almost every time I pair program with someone new, chances are I'll notice them doing something neat and ask them how they did it.

Here are some of my favorites.

I use bash as my default terminal, but most of these tips translate to other terminals as well.

_**Note:** This post isn't meant to teach the basics of using the terminal. There are many great resources online (I remember doing [Codecademy's Command Line course](https://www.codecademy.com/learn/learn-the-command-line) when I was starting out._

## The `-` operator

Do you find yourself switching back and forth between two directories often?

You can use `cd -` to change to the last directory you were in like this:

```shell
~ $ cd directory1
~/directory1 $ cd directory2
~/directory2 $ cd -
~/directory1 $
```

This also works with git when switching between branches:

```shell
~/my-project(main)$ git checkout feature-branch
~/my-project(feature-branch)$ git checkout -
~/my-project(main)$
```

## The `!!` operator

This happens a lot!

You type a command, only to get a "Permission denied" so you have to retype the command again, this time using `sudo`.

The `!!` operator echoes the last command you typed into your terminal.

You can use it like this:

```shell
$ some-dangerous-script.sh
=> Error: Permission Denied
$ sudo !!
=> Enter password for some-dangerous-script.sh: 
```

## {curly brace expansion}

If you ever need to run a series of very similar commands that differ by just a few characters (like for example, if you want to create a few filenames with lightly different extensions) you can use the characters that will be different between two curly braces and the command will run once for each one.

Like this:

```shell
$ touch file-{1,2,3}.md
$ ls
=> file-1.md file-2.md file-3.md
```

You can also pass in a range:
```shell
$ touch file-{1..3}.md
$ ls
=> file-1.md file-2.md file-3.md
```

## Search using Ctrl+R

Are you like me? Would you press the up button 20 times to avoid typing out a 7 character command?

This next one was a lifesaver for me!

You can type <kbd>Ctrl</kbd> + <kbd>R</kbd> followed by the first few letters of the command you want to search through your bash history and bring up the command you need.

(Sorry, I can't think of how to demonstrate that with a code snippet. Just go to your terminal, type in <kbd>Ctrl</kbd> + <kbd>R</kbd> and start typing).

## Aliases

Aliases are a great way to save time and keystrokes. If there's a command or a series of commands you find yourself typing often, it's making an alias can be very helpful.

In order to set aliases, first open the `~/.bashrc` file in your favorite editor and check if it has the following lines in it:

```bash
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
```

It should be there already, if it isn't just add it to the bottom of the file.

Next open `~/.bash_aliases` in your editor (or create it if it doesn't exist) and add your aliases in the following format:

```bash
alias something="definition"
```

Some playful aliases I have in my `.bash_aliases` are:

```bash
alias please="sudo "
alias yeet="rm -rf 
```

I also have a number of functions defined there, for more complex command series:

```bash
mk() {
	mkdir $1 && cd $1
}

gclone() {
	git clone "$1" && cd "$(basename "$1" .git)"
}
```

The `mk` alias takes a directory name as an argument, `mk`s the directory and then `cd`s into it.

The `gclone` alias takes a git repo, clones it, and then `cd`s into it.

After adding aliases to your `.bash_aliases` they should load automatically every time you start a new terminal session.

If you would like to use your aliases in your current session, run:

```bash
source ~/.bash_aliases
```

That's what I can think of for now.

Do you have any favorite tips and tricks?

Please please do share them! I always love learning new ones!