---
title: "Part 3: Add A Dead-Man's Switch To A Rails Application"
date: 2021-02-07 18:47:58 +0000
permalink: /part-2-add-a-dead-man-s-switch-to-a-rails-application-2b5f
header:
  teaser: /assets/images/posts/2021-02-07-part-2-add-a-dead-man-s-switch-to-a-rails-application-2b5f-cover.png
tags:
  - ruby
  - rails
  - twilio
  - tutorial
---

## Bonus Round!

In [part one](/part-1-adding-a-dead-man-s-switch-to-a-rails-application-bgp) and [part two](/part-2-add-a-dead-man-s-switch-to-a-rails-application-243j) of this series, we created a working deadman's switch in our rails app.

This part isn't necessary, but it can be helpful.

The deadman's switch we wrote will trip if it isn't reset after seven days (or however long you set it for). That may seem like a safe interval, but it would be nice to have a reminder if you haven't reset it in a few days and the deadline is coming up.

I set my switch up to send me an SMS reminder if I didn't reset it in 4 days, and then every day after that until the switch is either rest or if it trips.

That's what we will do in part three of this tutorial.

**Note:** this part of the tutorial uses Twilio to send SMS messages. You will need to sign up for a Twilio account. If you use my [referral link](www.twilio.com/referral/PWhqJW) to sign up, you will get $10 of credit, which should be last a while for our use-case.

## Getting Started

The first thing we need to do before getting started is to make sure we have a Twilio account. For our purposes, a "demo" account is enough. A demo account is free; it means you will have to register your phone number to receive texts, and you can't send SMS messages to other numbers, which is fine. Sending an SMS costs money ($0.0075 in the US); the $10 you get at sign-up by using my referral link should cover that for a long time.

After creating an account, follow the instructions to create a new project.

On the dashboard, you will need three pieces of information: The Account SID, Auth Token, and the account phone number.

![screenshot of the dashboard showing where to find the needed info. ](/assets/images/posts/2021-02-07-part-2-add-a-dead-man-s-switch-to-a-rails-application-2b5f-20715c.png)

Save these credentials in a safe place; we will need them for the next part.

**Note:** It's a bad idea to put API keys in your code as plaintext, especially if you put your code somewhere that's publicly accessible like GitHub. Someone can find them and use them to rack up quite the phone bill! Store them as environment variables instead. Heroku makes it easy to set [environment variables](https://devcenter.heroku.com/articles/config-vars#using-the-heroku-dashboard).

## Text me, maybe?

Now we have everything we need to set up our script to text us when it doesn't hear from us in a while.

First, put the following near the top of your rake task:

```ruby
include ActionView::Helpers::DateHelper
```
This isn't strictly necessary, but it will let us use `ActionView`'s `time_ago_in_words` method to format a nice human-readable message.

Next, let's set up a conditional to send the message only after the specified time that the app didn't hear from you. I set mine up to start bugging me after three days:

```ruby
if 3.days.ago >= Deadman.last_reset

end
```
(though for testing purposes, you can make the interval as small as a few seconds so you can trigger the SMS to send and make sure everything is working. Just remember to change it back before pushing to production).

Now, inside the `if` block, the first thing to do is to construct a message that the script will send:

```ruby
time_to_trigger = time_ago_in_words(Deadman.last_reset + 7.days)
message_body = "Your deadman switch will trigger in #{time_to_trigger}, please log in to your account and reset it."
```
You can, of course, edit this to fit your needs and taste.

Next, let's set up a Twilio client using the credentials we got from the Twilio dashboard:

```ruby
twilio_client = Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_ACCOUNT_TOKEN'])
```

Finally, you can  use the client to send an SMS message to your phone:

```ruby
twilio_client.messages.create(from: ENV['TWILIO_PHONE_NUMBER'], to: ENV['PHONE_NUMBER'], body: message_body)
```
The `from:` field is the Twilio phone number you got from your Twilio dashboard, and the `to:` field is your personal phone number (make sure to register it with your Twilio account if you're on the free "Demo" tier). The `body:` field is the message we constructed earlier.

The complete code should look something like this:

```ruby
include ActionView::Helpers::DateHelper

if 3.days.ago >= Deadman.last_reset
    time_to_trigger = time_ago_in_words(Deadman.last_reset + 7.days)
    message_body = "Your deadman switch will trigger in #{time_to_trigger}, please log in to your account and reset it."
    twilio_client = Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_ACCOUNT_TOKEN'])
    twilio_client.messages.create(from: ENV['TWILIO_PHONE_NUMBER'], to: ENV['PHONE_NUMBER'], body: message_body)
end
```

And that's it! That's all there is to it!

## Further Reading

I considered adding the capability of resetting my switch via SMS as well, by replying to one of the reminders.

I didn't end up going with that for various reasons, but if you would like to, here is a [blog post](https://www.twilio.com/blog/2018/04/sms-notifications-ruby-on-rails.html) I wrote a while ago on the Twilio blog that should help get you started.