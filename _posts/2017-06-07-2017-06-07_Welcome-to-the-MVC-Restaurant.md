---
title: "Welcome to the MVC Restaurant"
date: 2017-06-07 06:25:14 +0000
permalink: /welcome-to-the-mvc-restaurant-fb1709047914
header:
  teaser: /assets/images/posts/2017-06-07-2017-06-07_Welcome-to-the-MVC-Restaurant-0.jpeg
tags:
  - learning
  - writing
  - interviewing
categories:
  - 
---

* * *

### Welcome to the MVC Restaurant

#### A new look at an old&nbsp;analogy

_I was recently asked to describe the common components of web application frameworks. What purpose does each component serve? What is the benefit of separating each component from the others?_

_The most common architecture web frameworks follow is the MVC (Model, View, Controller) pattern._

_The best analogy by far that I’ve heard to explain the MVC pattern is the oft-repeated “Restaurant Analogy.” I didn’t want to repeat it again, so I sat there and tried to come up with an alternative analogy, but every analogy I came up with ultimately failed. Some sounded promising in the beginning, some I was even able to spin to some length, but in the end, none of them were able to explain MVC in as much detail as the restaurant analogy._

_Seeing that I had no choice, I resigned myself to publishing yet_ **_another_** _MVC restaurant blog post. I’ll try to add a detail or two here and there, and I hope to extend it somewhat to answer the second half of the question regarding separation of concerns._

![](/assets/images/posts/2017-06-07-2017-06-07_Welcome-to-the-MVC-Restaurant-0.jpeg)

### The Minimum Value&nbsp;Cafe

It’s been a long day; you’re hungry and grumpy, you just need a bite to eat before you go home. You slip into your favorite budget food spot, the somewhat crowded Minimum Value Cafe. Thankfully there’s an open table right there.

You sit down at the table and see the familiar menus. Some people like the one with the bright orange logo with a picture of a red panda hugging a bright-blue earth. Others prefer the menu with the red-yellow-green-blue ball logo; they say the waiters will serve you faster. There are others as well, though one thing everyone can agree on is to stay far away from the menu with the big blue “e” orbited by a gold ring, food ordered from there has been rumored to put a few too many innocent patrons down with nasty stomach bugs…

So you pick up your menu of choice. Some of these menus are getting pretty advanced; they open up to a page with your most commonly ordered dishes. As you are sitting and **browsing** your menu, you are startled to hear a voice from behind “Hello, my name is Yechiel, and I will be your **Controller** for the night (the waiters here have their quirks), are you ready to place your order?”

You point to your favorite tuna-and-egg sandwich, a double-shot espresso, and cheesecake for dessert. The waiter says “sure, it’ll take just a few milliseconds, can I get you anything to drink in the meantime?” and before you could respond, the waiter (err… **Controller** ) disappears in the back.

The back, far from the eyes of the common folks, is where most of the action happens. The **Controller** passes on your sandwich order to the sandwich boy, the coffee order to the barista, and the dessert order to the pastry chef (why these kitchen workers like calling themselves **Models** is anyone’s guess). The **Models** , in turn, rush to the storage room to fetch the ingredients, get back to their stations to cook/prepare/assemble it all. When everything is ready, they hand it to the waiter (sorry, sorry, I know you like being called **Controller** , it’s just hard to remember all the time, stop yelling at me like that!). The **Controller** then assembles it all nicely on a big tray engraved with “The **View** ” in cursive script, and brings it all out to you and sets it on your table.

This whole process was so quick; the food was prepared in front of you before you even took your finger off the menu!

### So what’s it&nbsp;mean?

That’s the analogy in brief, and that’s what happens every time you browse the internet.

![](/assets/images/posts/2017-06-07-2017-06-07_Welcome-to-the-MVC-Restaurant-1.png)

The process starts in your **browser** , where you enter a URL, click on a link, submit a form, etc. That sends a request to the server where a **Controller** picks it up. The **Controller** handles the request, passing it on to the appropriate **Models**. The **Models** are where the main logic of the application takes place. The **Models** retrieve the data you need from the database(s) and assemble it based on the user’s request. The **Model** then hands that data to the **Controller** who, using templates found in the **Views** , assembles it into a format the user will enjoy. The **Controller** then takes the assembled **View** and sends it back to the **browser** where the User gets entertained by endlessly repeating cat GIFs.

![](/assets/images/posts/2017-06-07-2017-06-07_Welcome-to-the-MVC-Restaurant-2.gif)

### **Separation of&nbsp;concerns**

Where this analogy really shines, in my opinion, is in answering the second part of the question: What is the benefit of separating each component from the others?

Let’s take a closer look at our restaurant. One can easily imagine a smaller establishment, where the chef is the one interacting with the customers, taking their orders, preparing them, and serving. Similarly, in smaller applications, you might be able to have all the logic needed in one file (that’s pretty much what happens in small static websites).

Once the restaurant grows however and starts offering a variety of dishes, and the client base becomes too big for one person to handle, it becomes more and more important that each employee knows their place and job.

![](/assets/images/posts/2017-06-07-2017-06-07_Welcome-to-the-MVC-Restaurant-3.gif)

Imagine the chaos if the waiter decides to “help out” in the kitchen, no chef would ever accept such an intrusion. How about if the chef decided to busy himself with setting the tables, while orders kept piling up in the kitchen, customers would get annoyed real quick.

Most importantly is the issue of accountability. When everyone has a well-defined job, the manager knows where to go when something goes wrong. Is the food burnt? Speak to the chef. Are patrons waiting too long for their orders? See if the waiter needs help.

In a well-oiled, well-defined system, every component has its job, and when things need fixing or tweaking, you know exactly where to go to fix them.

Similarly in your application. If every part of your code has its job and is in the right place, it makes it so much easier to catch and fix bugs, add features, and improve performance, without having to worry about stepping on the toes of any other component. After all, you never want to anger the ones who deal with your food&nbsp;;)

