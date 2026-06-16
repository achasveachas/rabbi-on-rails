---
title: "Creating My First Twitter Bot"
date: 2017-12-26 02:55:16 +0000
permalink: /creating-my-first-twitter-bot-b5e0da5c8cbb
header:
  teaser: /assets/images/posts/2017-12-26-2017-12-26_Creating-My-First-Twitter-Bot-0.png
tags:
  - bots
  - learning
categories:
  - 
---

* * *

### Creating My First Twitter&nbsp;Bot

#### Creating A Twitter Bot In&nbsp;NodeJS

![](/assets/images/posts/2017-12-26-2017-12-26_Creating-My-First-Twitter-Bot-0.png)

I know lately I’ve been a little quiet, I’ve pretty much taken a break from coding over Chanukah. So last night I figured that instead of partaking in the [ancient Jewish tradition of indulging on the finest Chinese cuisine](https://en.wikipedia.org/wiki/Chinese_cuisine_in_Jewish_culture_in_the_United_States) I would stay home and work on a project I’ve been meaning to explore; writing a Twitter bot.

![](/assets/images/posts/2017-12-26-2017-12-26_Creating-My-First-Twitter-Bot-1.jpg)

I chose something simple to start with. Anyone who owns a car in New York City knows the pain that is Alternate Side Parking (ASP). On certain days of the week, we are not allowed to park our vehicles on certain sides of the street during an arbitrary hour and a half. At the appointed minute an army of vultures in blue uniforms descend upon the city and any car whose owner was even a few minutes late in moving it gets adorned with an orange envelope bearing a costly fine.

Thankfully, there are a few days during the year (mainly legal holidays and days following heave snow storms) where we get a reprieve. I decided to make a bot that would tweet out during those days.

The truth is NYC already maintains a Twitter account that tweets the status of ASP ([@NYCASP](https://twitter.com/NYCASP)), but that account tweets every single day what the status is. I didn’t want my feed cluttered on days when ASP rules are in effect (which is most of the days), so I figured I would write a bot that would follow [@NYCASP](http://twitter.com/NYCASP "Twitter profile for @NYCASP") for me and retweet only on the days that ASP rules are suspended.

Thankfully there’s a Node package called [twit](https://github.com/ttezel/twit) which provides a Twitter API client that’s fairly easy to use.

In order to set up my bot, I used[this great tutorial](https://medium.com/@RabbiGreenberg/how-i-created-two-twitter-bots-ea4d4fbe96d7) by my friend and fellow [Flatiron School](https://medium.com/u/973c5cbfb09b) grad, [Ben Greenberg](https://medium.com/u/8b0c7fbdbada). If you are looking to write your own bot I suggest following his post for the initial setup, as well as instructions how to deploy to Heroku so your bot can go live. In this post I will just describe how I created the bot itself.

In the end, my bot looked like this:

```javascript
const twit = require('twit');
require('dotenv').config()
```

```javascript
const config = {
  consumer_key: process.env.consumer_key,
  consumer_secret: process.env.consumer_secret,
  access_token: process.env.access_token,
  access_token_secret: process.env.access_token_secret
};
```

```javascript
const Twitter = new twit(config);
```

```javascript
const userID = '102773464';
```

```javascript
const stream = Twitter.stream('statuses/filter', { follow: [userID] });
```

```javascript
stream.on('tweet', function (tweet) {
  if (tweet.text.includes('suspended')) {
    retweet(tweet.id_str);
  }
});
```

```javascript
const retweet = function (id) {
  Twitter.post('statuses/retweet/:id', { id: id }, function (err, res) {
    if (res) {
      console.log('Successfully Retweeted');
    } else {
      console.log(err.message);
    }
  });
};
```

In the first line I imported the `twit` package, then I defined the configuration needed for my bot to post. I hid the secret keys in environment variables that I accessed using `dotenv`.

I then defined a few variables: a `Twitter` variable for a new instance of twit using my configuration, a `userID` variable that holds the User ID of the [@NYCASP](http://twitter.com/NYCASP "Twitter profile for @NYCASP") Twitter account, and finally, I opened a twit `stream` that listened in to all activity associated with the [@NYCASP](http://twitter.com/NYCASP "Twitter profile for @NYCASP") twitter account.

Now that I had my stream going, I attached an event listener to the stream that fires a callback function every time a tweet is added to the stream. The function looks at the tweet’s text, and if it contains the word `"suspended"` it fires another function that retweets it.

Pretty simple really!

Now all that was left was to deploy to Heroku and wait for Christmas morning and see if my bot would retweet that morning’s suspension:

![](/assets/images/posts/2017-12-26-2017-12-26_Creating-My-First-Twitter-Bot-2.png)

Jackpot! It worked!

If you are a New Yorker who would like to follow my bot you can find it at [@AlterSideBot](https://twitter.com/AlterSideBot)

