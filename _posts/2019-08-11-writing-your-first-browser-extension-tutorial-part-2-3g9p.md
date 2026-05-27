---
title: "Writing Your First Browser Extension Tutorial - Part 2"
date: 2019-08-11 22:29:23 +0000
permalink: /writing-your-first-browser-extension-tutorial-part-2-3g9p
tags:
  - javascript
  - beginners
  - browsers
  - webdev
---

*This tutorial is based on a workshop I gave at the Codeland conference in NYC in 2019.*

*For the purpose of this tutorial we will use Firefox, though most concepts carry over to other browsers as well.*

*The code for this tutorial can be found [here](https://github.com/achasveachas/codeland)*

## Where were we?

In [part 1 of this tutorial](/writing-your-first-browser-extension-part-1-d5e) we created a fun little extension that reminds you to get off Twitter every ten minutes.

That was pretty fun (and, if you're like me, pretty useful 🤐), but when you think of browser extensions, the ones that come to mind are probably the ones that do something to the webpage. Either add something, remove something, or change the appearance.

In part 2 we will focus on that kind of extension.

## Manipulate Your DOM?

JavaScript programs that make changes to webpages do it using something called DOM Manipulation.

The DOM (Domain Object Model) is a JavaScript representation of an HTML page.

JavaScript has built in functions for adding, removing, and otherwise making changes to the DOM causing the underlying HTML page to change as well. This process is called DOM Manipulation.

We will be using DOM Manipulation in our next extension.

## Unbiasify

One of the major problems facing the tech hiring process is that of implicit bias in hiring.

Recruiters typically spend less than half a minute looking at a resume, and have to make lots of very quick decisions in a short amount of time. Under those circumstances it makes sense that our brain will try and take short-cuts and default to options that it feels are "safe". The problem is, those short-cuts aren't necessarily rooted in reality.

Quite a few studies have demonstrated that given two identical resumes with the only difference being that one of them has a photo and name of a white male and the other one has a photo and name of a demographic that has traditionally been underrepresented in tech, the white male resume will get much more responses than the URM.

This is not necessarily because the hiring managers in the studies were trying to be racist/sexist, it's more likely due to implicit biases that we are all born with and are very hard to correct for, especially if you aren't aware of them.

*(If you haven't yet, I suggest you take the [Implicit Association Test (IAT)](https://implicit.harvard.edu/implicit/takeatest.html). I found the results to be eye-opening)*

[Martin Huack](https://twitter.com/1Hauck) created an interesting extension to deal with this issue called [Unbiasify](https://www.unbiasify.com). Check out their website to see what it does.

We will implement a small part of it. We will change the way LinkedIn looks so that we don't see the pictures of any of our candidates. Instead we will swap out the profile pictures for a picture of a kitten!

(The original Unbiasify extension swaps the profile pictures out for a plain gray circle, but that's boring. Besides, the internet can never have too many kittens ;)

##Let's Get Started!

_**Note:** If you don't want to lose any of the code we wrote in part one you can make a new branch at this point. All the code we wrote is in [this repo](https://github.com/achasveachas/codeland)._

* The first thing we need to do is go to our `manifest.json` and change the `"matches"` key to tell our extension to run on LinkedIn:

```diff
    "content_scripts": [
        {
-            "matches": ["*://*.twitter.com/*"],
+            "matches": ["*://*.linkedin.com/*"],
             "js": ["first-extension.js"]
        }
    ]
```

* If we reload our extension in "about:debugging" and head to [LinkedIn.com](https://linkedin.com) we should see our alert pop up there. This is just to make sure everything is still working.

* Let's get rid of all of the code in `first-extension.js`.

* Before we write any code, we need to figure out which parts of the page we want to edit. Being that we want to swap out the profile pictures we need to head over to LinkedIn and see if we can find something all profile pictures have in common.

* Let's head over to [LinkedIn.com](https://linkedin.com), type "software engineer" in the search bar, and click on the "People" tab. This should give us a list of talented software engineers. What we want to do is swap out the profile pictures.

* Open up the "Inspect" tool (`ctrl+shift+i` or by right clicking on the page and selecting "Inspect Element").

* Navigate to one of the profile pictures, it should look something like this:
![screen shot of the devtools highlighting a profile picture](/assets/images/posts/2019-08-11-writing-your-first-browser-extension-tutorial-part-2-3g9p-21477e.png)

* We are looking for a class name that all of the profile pictures have in common, but none of the other elements on the page do.

* Playing around a bit, it seems like the class name we want is this one: `EntityPhoto-circle-4`.

* In fact, it would seem reasonable to assume that **all** of the profile pictures across LinkedIn would share the format `EntityPhoto-[shape]-[size]` (and to save you the effort, I verified that this assumption is correct), this means that we won't have to do any extra work to have our extension work across the whole LinkedIn! All we have to do is find a way to select all images with a class name that contains `EntityPhoto`!

* Let's write the code to do that. Add the following to `first-extension.js`:

```javascript
let images = document.querySelectorAll('img[class*="EntityPhoto"]')
```

* We are using JavaScript's `querySelectorAll` function to grab all of the `img` elements that have a class name that contains the substring `"EntityPhoto"` (the CSS selector `class*` selects any class that contains the provided value anywhere in the class name). This will give us an array of `img` elements which we assigned to the variable `images`.

* The next thing we need to do is swap out the `src` attribute of our profile pictures (which currently points at the actual profile picture) for a generic cat picture.

* You can use a picture of your own cat, or you can use this free picture from [clipartix](https://clipartix.com/kitten-clipart-image-28859/):
![smart looking kitten who would make an amazing engineer](/assets/images/posts/2019-08-11-writing-your-first-browser-extension-tutorial-part-2-3g9p-1d1042.jpg)

* Whichever picture you choose to use, save it to your computer as `kitten.jpg` and place it in our `first-extension` directory in a subdirectory called `images`.

* Next we need to tell our extension about our kitten picture. Add the following key/value pair to `manifest.json`:
```diff
    "content_scripts": [
        {
             "matches": ["*://*.linkedin.com/*"],
             "js": ["first-extension.js"]
        }
-   ]
+   ],
+   "web_accessible_resources": ["images/kitten.jpg"]

```
(Remember to add the comma after the `"content_scripts"` array)

* Now we can iterate over the `images` array we created earlier and point all of the `img`s at our kitten picture! We will do that using a `for` loop. Add the following to `first-extension.js`:
```javascript
for (i = 0; i < images.length; i++) {
    images[i].src = browser.runtime.getURL("images/kitten.jpg")
}
```
* What we are doing is we're going over our `images` array and for every image in it we are calling its `img.src` attribute and assigning it to a new URL; the URL of our kitten picture (the `browser.runtime.getURL` part is to get the root URL of our extension which changes every time the extension is loaded).

* We are now ready to see if our extension works! Head over to "about:debugging" and reload our extension, then head back over to LinkedIn and refresh the page. If we did everything right it should look something like this:

![Screenshot of linkedin with a bunch of kittens instead of profile picturs](/assets/images/posts/2019-08-11-writing-your-first-browser-extension-tutorial-part-2-3g9p-ef4e98.png)

_**Troubleshooting:** If you can't get it working you can try comparing your code to the code in [this branch](https://github.com/achasveachas/codeland/tree/aa2956743f98375dac264d69132f501020732105)._

* This looks like it should work, but if you refresh the page and try scrolling down you might notice that not all of the profile pictures turned to cats! The profiles on the second half of the page still contain profile pictures!

* The reason for that is that LinkedIn (like many other websites) uses something called "lazy loading". In short, in order to save time when pages load LinkedIn doesn't load the whole page at once, it only loads part of the page and loads the rest as you scroll down. The problem is that the script in our extension only runs once, when the page loads, so anything that was not on the page at the time the script ran won't get affected.

* We can fix this using a relatively new JavaScript feature called [MutationObserver](https://developer.mozilla.org/en-US/docs/Web/API/MutationObserver) that "observes" the page (or part of it) for any changes, or "mutations", and when it notices something changing it executes a function passed to it (a callback function).

_**Note:** The `MutationObserver` API is relatively new and may not work in all browsers_

* The first thing we want to do is wrap our existing logic in a function to make it easier to pass around:
```diff
+ function imageSubstituter(){
      let images = document.querySelectorAll('img[class*="EntityPhoto"]')

      for (i = 0; i < images.length; i++) {
          images[i].src = browser.runtime.getURL("images/kitten.jpg")
      }
+ }
```

* Next, let's create a new `MutationObserver` object and pass it our function as a callback: 
```js
const observer = new MutationObserver(imageSubstituter)
```

* The `MutationObserver` object we created has an `observe` function that takes two arguments: a DOM element to observe, and some configuration options passed as a JavaScript object.

* Let's first write our configuration options:
```js
const config = { childList: true, subtree: true }
```
This will tell our observer to observe, not just the element we tell it to, but any child elements as well.

* We are now ready to call our `observer`s `observe` function. We will pass it the entire body of our HTML page to observe, as well as the config options we wrote:
```js
observer.observe(document.body, config)
```

* We are now ready to see if our improved extension works. Head over to "about:debugging", reload the extension, and then go back to LinkedIn and reload the page. As you scroll down you should see all of the profile pictures to to cat pictures as they load!

_**Troubleshooting:** If the extension isn't working double check you got everything right (check the code [here](https://github.com/achasveachas/codeland/tree/unbiasify) for reference)._

_If you are sure you got everything right and it **still** isn't working it's possible that you browser doesn't support the `MutationObserver` API. As mentioned, it's a relatively new feature that isn't universally supported._

## Congratulations!

Congratulations! We have now created two working browser extensions!

I hope I gave you enough information to start working on your own browser extension.

If I did inspire you to make something awesome please reach out to me here or on [Twitter](https://twitter.com/yechielk) and share what you made!