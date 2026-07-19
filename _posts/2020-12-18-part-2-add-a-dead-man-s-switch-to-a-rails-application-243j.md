---
title: "Part 2: Add A Dead-Man's Switch To A Rails Application"
date: 2020-12-18 04:57:34 +0000
permalink: /part-2-add-a-dead-man-s-switch-to-a-rails-application-243j
header:
  teaser: /assets/images/posts/2020-12-18-part-2-add-a-dead-man-s-switch-to-a-rails-application-243j-cover.jpeg
tags:
  - ruby
  - rails
  - twilio
  - tutorial
series: "Dead Man's Switch in Rails"
---

### Ah Yes, Where Were We?

In [part 1](/part-1-adding-a-dead-man-s-switch-to-a-rails-application-bgp) of this tutorial, we learned how to set up the part of the deadman's switch that allows us to reset the switch.

In part 2, we will get to the main part; how to set up a script that will run if something happens and the switch isn't reset in a given amount of time.

### Rake It In

The standard way of running scripts in Rails apps (and Ruby environments generally) is using Rake tasks.

Rake tasks are, in their most basic form, Ruby scripts that you can run using the command `rake [task-name]`.

In fact, chances are you've run quite a few already! If you've run commands like `rails db:setup`, `rails db:migrate`, these are rake tasks that come built-in with Rails for setting up your database!

We can write our own Rake tasks as well. They usually live in the `lib/tasks/` directory of our Rails app, and the files use the `.rake` extension instead of the `.rb extension Ruby scripts usually use.

Let's start by creating a file `lib/tasks/deadmans-switch.rake`.

In the file, let's put the following:

```ruby
desc "Deadman's Switch"

task :deadman_switch do
    puts "Our first task!"
end
```

At this point, we have a very basic Rake task. If you run `rake -T` in your terminal, you should get a list of all the Rake asks you have available, including this one:

```shell
rake deadmans_switch                       # Deadman's switch
```

On the left side, we have the name of our task, and on the right, the description that we gave it in the first line following the `desc` keyword.

If we run `rake deadmans_switch` in our terminal, we should see the following:

```shell
$  rake deadman_switch 
=> Our first task!
```

Of course, at this point, our task does nothing more than print a line to let us know it's there, but we can replace that with any Ruby code we want, so let's do that!

Replace the contents of the task with:

```ruby
    if 7.days.ago < Deadman.last_reset
        puts "Still alive!"
    else
        puts "Executing Deadman Switch!"
        # whatever you want to do goes here
    end
```

This script now uses the `.last_reset` method we put on our `DeadmansSwitch` class to check when you last reset the switch. If it was less than seven days ago, it just prints "Still alive!" and exits; if you didn't reset the switch in over a week, it'll execute whatever script you tell it to.

**Note:** I put a week in my script because I figured that was a reasonable timeframe for my needs. You can change that to 2 days, two weeks, a month, a year, whatever you feel the right timeframe for your needs. Ruby's `Time` class offers great methods for denoting a timeframe, which you can use similar to the `7.days.ago` that I used.

Now if you run `rake deadmans_switch` in the console, you should get:

```shell
$  rake deadman_switch 
=> Still Alive!
```

At this point, you can start working on the actual body of the script, which will be different depending on what it is you need a dead man's switch, so I'll leave you to it.

If you want to test and debug the script by running it and don't want to wait seven days for the switch to expire, you can change the `7.days.ago` in your `if` statement to something more reasonable like `7.minutes.ago`. Just don't forget to change it back when you're done.

### Have You Been Triggered?

Now that we have a script and a way to ensure it only runs after a given time, there's one more thing we need to do. We probably don't want this script to run more than once.

For local scripts that run using a cron job, this isn't such an issue. You can probably use the script to reset the crontab. But this is a script running on Heroku where we don't have access to the scheduler from within the script, so we'll have to get creative.

One option I explored, which turned out to be a dead-end for reasons I'll explain soon, but I'll include it here anyway purely for its entertainment value, was to put the following on the last line fo my script:

```ruby
File.delete(__FILE__)
```

`__FILE__` is a Ruby constant representing the current file, so what that line of code does is it deletes the current file once it reaches that line. Sort of like those spy movies where you get a note telling you to destroy it once you're finished reading it.

At first, I didn't think it would work. Spending the better part of last year developing for Windows servers and battling numerous "file in use" errors, I was sure Linux wouldn't let me do it either. But I did it just for kicks, and it turns out Linux is a lot more trusting! You can even try it yourself; create a test file, paste the above line of code, run it using Ruby, and watch it disappear!

While that's a pretty fun solution, unfortunately, it won't work for our purposes. Heroku, as mentioned in Part 1, uses an ephemeral file system, so even if we delete the file containing the script, the next time the app deploys, Heroku will do a fresh pull from GitHub, and our file will reappear.

If we want to keep track of whether our script ran, we will need to use something that persists, like a database entry. Fortunately, I'm a psychic who can see into the future, and if you remember, in Part 1, when we created our `deamans_switches` table, we added a `triggered` column, and we will now make use of it.

The first thing we will do is add two more methods to our `DeadmansSwitch` class in `app/models/deadmans_switch.rb`:

```ruby
    def self.triggered
        create(triggered: true)
    end

    def self.triggered?
        where(triggered: true).size > 0
    end
```

The first one, `.triggered`, creates a new row in the database, but unlike a regular row, we set the `triggered` column to `true`.

The second method, `.triggered?`, queries the database and checks if there are any rows where `triggered` is set to `true` and returns `true` if there is at least one such row.

Now let's go back to our Rake task and put those to use.

The first thing we will do is add the following line at the end of the script after everything we wanted to run ran:

```ruby
Deadman.triggered
```

This will enter a row in the database with `triggered: true`.
 
Next, all the way at the beginning of our script, in the very first line, we will put the following:

```ruby
abort if Deadman.triggered?
```

This will check the database and see if there are any rows where `triggered: true` and abort the script if it finds any.

### Getting Scheduled

At this point, we have a working deadman's switch. The only thing left is to deploy it along with our Rails app and set up a scheduler to run it.

My app is deployed on Heroku, so the instructions will be for getting set up on Heroku. If you have a different setup, things will work differently for you.

So once you've written up all the code, committed it, and pushed it off to Heroku, here is how to go about scheduling your script.

From the Heroku dashboard, navigate to the "Resources" tab.

Once in the "Resources" tab, find the button that says "Find more add-ons" and click on it.

Search for [Heroku Scheduler](https://elements.heroku.com/addons/scheduler) and install it and provision it to your app.

Once it's installed properly, you should see it under add-ons in your resources tab. Click on the link to the Scheduler and then on the button that says "Add Job."

You will be prompted to set a schedule to run your task (I set it to run every night at midnight) and which command to run, which you should set to `rake deadmans_switch`.

Hit "Save Job," and that's it, you're all set!
