---
title: "From Job Applications To Compatibility Lists"
date: 2017-08-06 16:55:06 +0000
permalink: /from-job-applications-to-compatibility-lists-6e6a2068a556
header:
  teaser: /assets/images/posts/2017-08-06-2017-08-06_From-Job-Applications-To-Compatibility-Lists-0.png
tags:
  - 
categories:
  - 
---

* * *

### From Job Applications To Compatibility Lists

#### How I repurposed my bootcamp&nbsp;project

Throughout the time I was learning to code, I was very fortunate to have the full support of my manager at my current job. He encouraged me to upgrade my skill-set, and even let me take [Flatiron](https://medium.com/u/973c5cbfb09b) lessons during downtime.

Naturally, when I [graduated](https://blog.yechiel.me/reactjs-app-with-rails-api-4ffb12ba6608), I was excited to let my boss know about it, and, as expected, he was happy for me as well, asking me to show him my final project.

![](/assets/images/posts/2017-08-06-2017-08-06_From-Job-Applications-To-Compatibility-Lists-0.png)

As I showed him the [Job Applications Tracker](http://app-tracker-react.herokuapp.com/) I made, he seemed genuinely interested in it, and he asked if I thought I could tweak it a bit to help our integrations department keep track of which payment gateways and shopping carts were compatible with our company’s payment processing platforms.

Up until now, compatibility requests were handled on a one-by-one basis, with the results tracked in separate excel sheets without any central database keeping track. If I could just tweak my app a bit, it would track payment gateways instead of job applications. Now there would be one central place where anyone in the integration team could go to see if a given gateway or shopping cart has already been looked into, and if not, record the results of the current research.

That sounded like a fun task. The biggest challenge turned out to be setting up a Rails environment on my work computer which runs Windows. The simplest answer turned out to be setting up a virtual machine running Ubuntu, though getting it to play nice with our corporate firewall proved to be far from simple.

Finally, I got my environment set up. At that point, all it took was two days of down time at work (one to tweak the Rails API, and another to update the ReactJS client) and Compatibility List was ready to demo.

Some of the features had to be changed. For example, in my Job App tracker users can only see their own job applications, for the compatibility request tracker, I wanted anyone in the company to be able to see all compatibility requests. That involved playing around with the routes in my REST API. My API was built using a nested routing scheme, where a request would be sent to `/users/56/applications` to get a list of all job applications belonging to user number 56. In the compatibility list tracker I dropped the nested routing, and now any authenticated user could visit `/applications` to see the list of all applications.

Another difference was regarding authentication. In my job app tracker, I did not require authentication to view a user’s applications; I did that to make it easier for job applicants to share their applications with their career coach or mentor. For the compatibility request app I was dealing with sensitive company information, I had to tighten the requirements so only people within the company would be able to view compatibility requests.

For the same reason, I eliminated the traditional sign-up form and implemented a scheme where only existing admin users could register new users.

All told, I’m pretty thankful to Flatiron for teaching us the importance of writing clean, modular, and tested code. Having tests meant being confident that the underlying app wasn’t breaking as I was changing around features, and having my code in discreet modular components meant that any changes I made were mostly local, and didn’t necessitate hunting down bugs introduced throughout the rest of the codebase.

Most of all I’m thankful to my boss (Hi Motti!) for giving me the chance to put my new knowledge into real-world practice!

