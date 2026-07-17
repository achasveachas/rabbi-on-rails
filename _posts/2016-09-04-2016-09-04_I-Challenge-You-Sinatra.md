---
title: "I Challenge You Sinatra"
date: 2016-09-04 21:11:15 +0000
permalink: /i-challenge-you-sinatra-c6f875e29db7
header:
  teaser: /assets/images/posts/2016-09-04-2016-09-04_I-Challenge-You-Sinatra-0.jpeg
tags:
  - sinatra
  - learning
categories:
  - 
---

* * *

### I Challenge You&nbsp;Sinatra

I finally finished the Sinatra section of the [Learn.co](http://learn.co/with/achasveachas) curriculum, and that means I have to make a complete Sinatra app from scratch.

I’ve [blogged in the past](https://medium.com/coding-hassid/gem-install-swim-82ff7a95e605#.mip8xbsxj) how being dropped into a project is the best way to learn about it, and this was true in this case as well; I’ve learned more Sinatra in the process of making this project than I did in the whole preceding section of lectures and labs.

The first step of course was coming up with an idea for my project, so last Shabbat I was talking to a developer friend and asked him if he had an idea for a Sinatra app I could make. He started rattling off different ideas and somewhere in between a blog and a fishing app he mentioned “…you could try a reddit clone… actually never mind, that’s probably too complicated…”

I didn’t need anything more than that, and immediately the my wheels started churning thinking of the the different features, models and associations my app would need.

As soon as Shabbat was out I headed straight to my computer and started putting the plan to action.

![](/assets/images/posts/2016-09-04-2016-09-04_I-Challenge-You-Sinatra-0.jpeg)

_Freddit home screen_
{: .image-caption}

Usually the hardest part is getting started, thankfully this was taken care of by my side project; the Scaffold generator I built for the Corneal gem (read about it [here](https://medium.com/coding-hassid/of-scaffolds-and-gems-140bdbe2e005#.5otcmzvdn)).

My reddit app (which I called “freddit” after Flatiron’s naming convention that gave us “[fwitter](https://github.com/achasveachas/sinatra-fwitter-group-project-v-000)”) is a very basic clone. It has users that can sign up, log in, start threads called Conversations, reply to other user’s Conversations, edit posts, and some other features which I will describe later.

The complexities came up in the details. I had to come up with methods that would tell my app which user was logged in, and only allow the posts and conversations to be edited by the user that created them.

It got more complicated when I allowed certain users to be “moderators” with the ability to edit posts by any other user, and even to ban a user when needed.

![](/assets/images/posts/2016-09-04-2016-09-04_I-Challenge-You-Sinatra-1.jpeg)

_Banned user_
{: .image-caption}

Handling all of this complexity led to some pretty ugly looking code, but thanks to some really helpful friends and the great instructors at [Learn.co](http://learn.co/with/achasveachas) (shout out to MendelB!) I was able to refactor it to something a little more manageable.

If you want to take a look at the code you can find it on [GitHub](https://github.com/achasveachas/freddit). I would really appreciate any feedback you can offer.

Happy coding!

