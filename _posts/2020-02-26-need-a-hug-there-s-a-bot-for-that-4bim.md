---
title: "Need a hug? There's a bot for that!"
date: 2020-02-26 19:22:27 +0000
permalink: /need-a-hug-there-s-a-bot-for-that-4bim
header:
  teaser: /assets/images/posts/2020-02-26-need-a-hug-there-s-a-bot-for-that-4bim-cover.jpg
tags:
  - bots
  - python
---

Hey all!

I know I haven't posted in a while, but after a long break I finally had a free weekend and was able to work on a side project (my first one in over a year! Don't believe the gatekeepers, you can have a successful career without side projects!)

It all started a few weeks ago when I was feeling down and felt like I could really use a hug.

Not being close to anyone with whom I'm friends on a hugging basis, I did the next best thing and turned to Twitter:

<blockquote class="twitter-tweet"><a href="https://twitter.com/i/web/status/1227616299548889090">Tweet</a></blockquote>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

Sometime later, I was tweeting with a friend who was feeling down, and they mentioned that they could use a hug as well. I immediately sent them a (virtual) hug as well. And the idea came up for a bot that would help people feeling down by sending hugs at them!

![a cat hugging her teddy bear](/assets/images/posts/2020-02-26-need-a-hug-there-s-a-bot-for-that-4bim-2194e6.gif)

I'm no stranger to Twitter bots, having written one some time ago:

[Creating My First Twitter Bot](/creating-my-first-twitter-bot-b5e0da5c8cbb)

This time I decided to write one in Python.

Python has a great library for interacting with Twitter called [tweepy](http://www.tweepy.org/), and even a library around [Giphy](https://github.com/Giphy/giphy-python-client) that makes things like getting a random gif of a hug pretty straightforward!

Between those two libraries, I didn't have to write much code on my own. The whole bot is about 35 lines of code!

I followed this dev.to post by [@emcain](https://dev.to/emcain) for instructions on how to get my bot set up on Heroku: 
[How to Set Up a Twitter Bot with Python and Heroku](https://dev.to/emcain/how-to-set-up-a-twitter-bot-with-python-and-heroku-1n39)

And by the end of the weekend, [@ICanHazHugzPlz](https://twitter.com/ICanHazHugzPlz) was born!

![a rabbit saying "do you need a hug? Have one! Maybe you do even if you don't think so"](/assets/images/posts/2020-02-26-need-a-hug-there-s-a-bot-for-that-4bim-2dd0c7.gif)

## Scope Reduction

Of course, no project comes out the way you expect it.

I had initially envisioned that the bot would reply to people asking it for hugs with a gif of a hug.

It turns out that to implement that, I would have to work out a queue that could keep track of which tweets the bot already replied to. That queue would need to maintain state between restarts; otherwise, the bot would keep spamming anyone who tweeted at it every time the script restarts (multiple times a day on Heroku's free dyno), as my bots earliest followers found out the hard way (sorry!!!)

I wasn't planning on spending more than a weekend on the project, so in the end, I settled on a bot that tweets a hug at the world every few hours.

## Show Me The Code!

If you would like to take a look at the code for the bot, you'll find it here (including the failed implementation of the replying version of the bot on a separate branch):

[GitHub: achasveachas/hug-bot](https://github.com/achasveachas/hug-bot)

And of course, if you'd like to bless your Twitter timeline with wholesome hugs, please give my bot a follow at [@ICanHazHugzPlz](https://twitter.com/ICanHazHugzPlz)!

Until next time!

![Rory Gilmore from Gilmore Girls giving a hug](/assets/images/posts/2020-02-26-need-a-hug-there-s-a-bot-for-that-4bim-1e56d9.gif)