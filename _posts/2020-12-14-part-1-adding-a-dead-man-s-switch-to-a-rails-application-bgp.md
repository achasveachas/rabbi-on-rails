---
title: "Part 1: Adding A Dead-Man's Switch To A Rails Application"
date: 2020-12-14 02:05:09 +0000
permalink: /part-1-adding-a-dead-man-s-switch-to-a-rails-application-bgp
header:
  teaser: /assets/images/posts/2020-12-14-part-1-adding-a-dead-man-s-switch-to-a-rails-application-bgp-cover.png
tags:
  - rails
  - scripting
  - ruby
---

### Content Warning
_The subject of this post is a bit morbid and deals with contemplating our mortality. If that upsets you, feel free to skip the introduction and go straight to the technical parts of the implementation in the section titled **"The Good Stuff."**_

### Introduction
I was recently thinking about the concept of a dead man's switch.

For those who are unfamiliar, a dead man's switch is a process that is designed to run automatically unless someone steps in to stop it. The idea is to increase the resiliency and/or safety of a system by having a safety mechanism that will stop it unless someone consciously steps in and overrides it.

One of my favorite examples is in trains where the breaks are engaged by default. To release the breaks, the conductor has to lift a handle or a pedal and keep holding it. The moment the conductor lets go of the pedal, the breaks will engage and stop the train. The idea behind the switch is that if something were to happen and the conductor was to pass out, the train won't continue barreling down the tracks; instead, it would come to a screeching halt immediately.

|![A ‘deadman’ pedal in a diesel-electric railway locomotive](/assets/images/posts/2020-12-14-part-1-adding-a-dead-man-s-switch-to-a-rails-application-bgp-f0f06d.jpg)|
|:--:|
|A ‘deadman’ pedal in a diesel-electric railway locomotive|

Many other systems have similar concepts, even if they don't contain physical switches.

For example, a computer might contain a script designed to run automatically after a few days unless the timer gets reset.

For example, many of us have things we might want to happen in the event that something terrible happens to us. Maybe we want to pass on the passwords to important accounts or notify loved ones about a life insurance policy, or perhaps to wipe out some deep dark secret we want no one to find out about.

One way we could go about it is to set a cron job on our computer to run every day. The cron job could look at a file and see when it was last updated, and if it wasn't updated in, say, over a week, it'll run a script that sends an email or does whatever else it is we want it to do.

There's a limitation with that, and that is that it assumes your computer will be on, which is not a given for my personal computer.

The next best option is to have my switch hosted in the cloud somewhere, though that comes with some expenses, and access to reset the times is a little more complicated than updating a file on my computer.

The idea I came up with was to add the switch to my portfolio site. It's the only website I own, so I could do whatever I want with it. I'm already paying for hosting, so there's no extra expense for the switch, so it made sense for me.

### The Good Stuff

This post assumes you already have a Rails app and that you have a rudimentary knowledge of Ruby and Rails.

My Rails app is hosted on Heroku. The tutorial's Rails portion should apply to any Rails app no matter where it's hosted, but some of the parts around running the sitch are Heroku specific. However, there are probably parallel mechanisms for other hosting options as well.

There's one part of the tutorial that requires a Twilio account with an associated project. It's not completely necessary, but if you want your switch to send out reminders as it gets closer to triggering, you might want to create a Twilio account.

Creating the account is free, and if you use my [referral link](www.twilio.com/referral/PWhqJW), you'll get $10 SMS credit, which should be more than enough for our purposes.

Our dead man's switch will need a few components:
1. A way to reset the switch.
1. A script that will run every day and check if you reset the switch.
    - If you did reset the switch recently, the script would abort.
    - If you did not, the script would do whatever it is you want it to do.
    - Once the script runs, we want a way to keep track of that, so it doesn't run again.

We'll start with the way to reset the switch.

If we were hosting this switch locally, a simple way to do this would be to look at the last time a given file was updated, and then keep updating that file every day.

Unfortunately, that wouldn't work for a script hosted on Heroku. Heroku uses an ephemeral filesystem for its apps, and every time the app gets redeployed, or if it crashes and has to be restarted, or even if it's taken down for routine maintenance, Heroku makes a fresh pull on the repo and any changes you made to the filesystem get overwritten.

We have to find a way to keep track of when the switch was reset, and a way that will persist.

I did it by creating a database table where I could enter rows containing a timestamp and then check the timestamp of the last row added.

Once I was already making a table, I figured I could add an ActiveRecord model to my app. That would give me some built-in ActiveRecord methods to interact with my table to read and update it.

### Let's Start Generating!

So let's start by opening up our terminal and generating our migration:

```shell
rails generate model CreateDeadmansSwitch triggered:boolean
```

This command created a number of files. The ones we care about are `db/migrate/[migration-id]_create_deadmans_switches.rb` containing our database migration for a `deadman_switches` table that has the standard timestamps columns (as well as a boolean column called `triggered`) we will discuss later).

The second file we care about is in `app/models/deadmans_switch.rb` that creates our `DeadmansSwitch` class.

Let's open up `db/migrate/20201211142929_create_deadmans_switches.rb`:

```ruby
class CreateDeadmansSwitches < ActiveRecord::Migration[5.2]
  def change
    create_table :deadmans_switches do |t|
      t.boolean :triggered

      t.timestamps
    end
  end
end
```

Before we run this migration, let's make one small change:

```diff
-    t.boolean :triggered
+    t.boolean :triggered, default: false
```

We added a default value of `false` to the `triggered` column, so that is the value it will contain unless we specify otherwise.

Now we can go back to our terminal and run:

```shell
rails db:migrate
```
That will run our migration and add the `deadmans_switches` table to our database schema.

### Models Models Everywhere

Now that we have our database set up let's look at our model in `app/models/deadmans_switch.rb`.

Currently, our model is pretty empty:

```ruby
class DeadmansSwitch < ApplicationRecord
end
```

Let's add two class methods to our class; one to reset the switch and one to check when it was last reset:

```ruby
class DeadmansSwitch < ApplicationRecord

    def self.reset
        create
    end

    def self.last_reset
        last&.created_at || Time.now
    end

end
```

We added two class methods.

The `reset` method creates a new instance of the `DeadmansSwitch` class, adding a new row to the database.

The `last_reset` method looks at the last row in the database and, if it finds one, returns the date and time it was created on; otherwise, it returns the current time (this is to protect against an edge case where we run the app before we rest the switch for the first time).

### Routing

Next, we need a route that will listen for, and trigger our switch.

My setup relies on two assumptions that apply to my app.

First, I have an `AdminController` that handles all the admin-related routing in my app.

Second, in my `AdminController`, I have a helper method called `is_admin?` that checks if the current user is an admin.

The details of your app may vary, so adjust accordingly.

In `config/routs.rb` add the following:

```ruby
get 'deadman/reset', to: 'admin#reset'
```
This sets up a route at `/deadman/reset` and routes it to the `reset` function in my `AdminController` and gives us access to a `deadman_reset_path` function that points to the new route.

If you have your app running, don't forget to restart it in the terminal for any routing changes to take effect.

Next, let's add that function in `AdminController` (or whichever controller you decided to use for your app):

```ruby

    def reset
        if is_admin?
            DeadmansSwitch.reset
            redirect_to admin_root_path
        else
            redirect_to login_path
        end
    end
```

This checks if the current user is an admin (you don't want just anyone who happens upon the URL to have the ability to reset your switch).

If the user is an admin, we call `DeadmansSwitch.reset` and redirect back to the page that called it; in my case, to the admin page (again, the routing in your app might be different, so adjust accordingly).

### What A View!

Now that we have that in place let's use it in our app.

Where exactly you put this in your app depends on the layout of your app. Ideally, you would put it in a part of your app that only you can access, like an admin console or something.

This is what I have in my app, feel free to style it as elaborately, or plainly, as you wish:

```erb
<%= link_to "Reset Switch", deadman_reset_path %> <small>(Last reset <%= time_ago_in_words Deadman.last_reset %> ago)</small>
```
This creates a link to our reset route, followed by a small helpful note which uses the `time_ago_in_words` helper method to display when the last time you reset the switch.

Here is what it looks like on my portfolio:

![A screenshot showing the link and the above text. ](/assets/images/posts/2020-12-14-part-1-adding-a-dead-man-s-switch-to-a-rails-application-bgp-13a1eb.png)

So now we have part of our dead man's switch in place, the part where we can reset it every day, so it knows we're still around and doesn't trigger our script.

In part 2, we will speak about how to write the script that checks our switch and runs if we haven't reset it in a while.