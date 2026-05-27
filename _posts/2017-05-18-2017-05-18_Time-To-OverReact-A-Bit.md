---
title: "Time To OverReact A Bit"
date: 2017-05-18 01:50:44 +0000
permalink: /reactjs-app-with-rails-api-4ffb12ba6608
header:
  teaser: /assets/images/posts/2017-05-18-2017-05-18_Time-To-OverReact-A-Bit-0.png
tags:
  - 
categories:
  - 
---

* * *

### Time To OverReact A&nbsp;Bit

#### Building a ReactJS application with a Rails API&nbsp;back-end

Hey, guys! I’m pretty pumped right now!

After about a year of coding late into the nights, and all through the weekends, I finally made it to the end of [Flatiron School](https://medium.com/u/973c5cbfb09b)’s Full Stack curriculum! That’s a really exciting accomplishment, and I couldn’t have done it without the help and support of so many people.

But before I could actually celebrate, there was the last hurdle, the final challenge. I had to put all the knowledge I’ve learned into practice and build an entire full-stack app from scratch.

Everything I learned until now; about back-end development with Ruby/Rails, database calls, front-end architecture with JavaScript/React, building and calling API’s. All of that would come together in this last and final project.

#### Where To&nbsp;Start?

The hardest part was, of course, thinking of an idea for an app. It took a while, but eventually, I figured, hey, I’m in middle of a career switch, I’m probably going to be applying for a heck of a lot of jobs over the next few weeks (I still find it hard to believe there’s someone out there who would pay me to do this stuff…), why not make an app to help me keep track of all these job applications?

So with that out of the way it was time to start working on the actual app.

Flatiron’s philosophy is that they don’t teach you code, they teach you to learn how to code. So the projects you make are all arranged in such a way, that while you definitely have the tools you need to build them, there’s very little hand-holding on Flatiron’s part, and quite a lot of researching and head-banging on the student’s part (see [gem install swim](https://blog.yechiel.me/gem-install-swim-82ff7a95e605) for my thoughts on the first project).

That’s how all of the personal projects were, you can imagine the final project was all of that squared. In fact, while the curriculum did an excellent job teaching us how to build Rails apps, and they also taught us how to build great client-side applications using React, there was pretty much nothing that prepared us for putting the 2 together. How to get your React application to talk to your Rails API?

#### Design Choices

I started reading and came across two different approaches:

The first one sounded pretty attractive early on. It was the approach advocated by the authors of [Fullstack React](https://www.fullstackreact.com/) (THE handbook on React programming). They basically advocated putting a directory IN your Rails app for the client-side application, so the app would essentially be talking to itself.

This approach had a certain elegance to it, it kept your app together in one place, you only have to worry about one app breaking.

The second approach was a pattern I’ve seen a few people use (including Flatiron Instructor [Luke](https://medium.com/u/f816159644c4) in one of his study groups). It involves setting up 2 separate apps, a Rails API for the back-end, and a React app for the client-side application. The React app would then communicate with the Rails API like it would with any external API.

Even though I was initially leaning towards the first approach, eventually I ended up going with the second one for a few reasons. For starters, separating my front-end from the back-end API makes for much cleaner code. My React app doesn’t have to know anything about how the Rails app works. In fact, I could swap out my React app for an Angular one (or Vue, or Ember, or whatever “framework of the week” pops up next) without having to touch my Rails API. I could even have 5 different apps all talking to the same back-end API.

I also figured using this pattern would make things easier in case I messed up badly and would have to scrap the whole thing and start over; having a separate back-end would make that process a lot easier.

#### Testing, Testing, 1..2..3..

So now that I had these design questions settled, it was time to start working on the actual app; well, actually two apps.

First I worked on the Rails API, being that I am pretty familiar with Rails, having already built 2 Rails apps in the past, this part was a breeze. The new challenge I took this time was writing it using the TDD pattern (or test-Driven-Development) where before coding any feature I would first write tests for it, and then write code that would get those tests passing.

TDD is not new to me, the entire Flatiron curriculum is written in a TDD pattern, where labs have tests that fail when you start and you have to write the code to get them passing, but this project was the first time I actually wrote tests myself.

#### Get Reactin’

Once I had the back-end set up, it was time to work on the client side React app.

I’m still fairly new to React, and even though Flatiron did a great job teaching it, it still took an enormous amount of time (and frustration) to get the app up and running. Add to it the fact that I still have my 9–5 job, and you’re talking weeks of late nights and weekends spent at the keyboard.

Eventually, I decided to take a few days off work, and focus on the app full-time.

Finally after a 3-day sprint of coding more than 15 hours a day App-Tracker-React was ready, and with it, my year-long journey with Flatiron!

![](/assets/images/posts/2017-05-18-2017-05-18_Time-To-OverReact-A-Bit-0.png)

It’s been a crazy year, with many ups and downs, my family had to put up with a lot (not to mention, my caffeine infused body), and now that it’s over I can’t wait to see what’s next!

If you want to check out my app you can find it here: [App-Tracker-React](https://app-tracker-react.herokuapp.com/)

The code is open source on GitHub, suggestions and feedback are welcome. You can find the repo for the Rails API [here,](https://github.com/achasveachas/app-tracker) and the ReactJS client [here](https://github.com/achasveachas/app-tracker-react).

As always, Happy Coding!

