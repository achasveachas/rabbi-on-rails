---
title: "It’s All In The Timing"
date: 2017-10-10 12:10:38 +0000
permalink: /all-about-timing-attacks-f71238a13936
header:
  teaser: /assets/images/posts/2017-10-10-2017-10-10_It-s-All-In-The-Timing-0.jpg
tags:
  - 
categories:
  - 
---

* * *

### It’s All In The&nbsp;Timing

#### Timing Attacks For&nbsp;Dummies

As a developer with an interest in security; every once in a while I learn of a new vulnerability that is so insidious and so clever it makes my hair stand on end. Today it’s timing attacks.

![](/assets/images/posts/2017-10-10-2017-10-10_It-s-All-In-The-Timing-0.jpg)

Say you have an API that clients can use to get information. To make sure the information only goes to the intended parties you require your clients to authenticate themselves using an API key, which is a random string they send along with each request. When a request comes in, you compare the API key they sent with the key you have on file, if the keys match, you know the client is who they say they are.

Timing attacks are a clever workaround for hackers with patience to get this private info without a key. How do they do it? Using math and statistics, and some exact measurements.

You see, at the heart of the function that compares the API key that was sent with the API key on file is the algorithm used to compare the 2 strings. That algorithm usually looks something like this (in pseudo-code):

> Go through the string being sent in and check the first character, if it matches the first character of the string on file check the next character, if that one matches go on to the next one, etc. until you get to the last character. If the last character matches return ‘true’, if any of the characters checked don’t match return ‘false’.

The vulnerability is in the last line. Let’s say the API keys are 15 characters long, the attacker will send a few hundred requests using a few hundred strings that look like `a00000000000000`, `b00000000000000`, `c00000000000000`, etc. sending a few hundred of each. They will then very carefully analyze how long it takes the server to reject their request. Using statistics, they will find that one of the versions of their string takes on average just a few milliseconds longer to reject. The reason for the slight delay is simple; most of the strings were rejected as soon as the first character was compared while one string (let’s say it was `g00000000000000`) passed the first letter and was only rejected when it got to the second letter. The hackers now know that the first letter of the API key is the letter `g`.

The difference is extremely subtle and can be affected by many factors (such as internet speed, latency, environmental factors, etc.) That is why 100s of requests are needed, in order to get a statistically significant result.

The hackers will now repeat the process using the strings `ga0000000000000`, `gb0000000000000`, `gc0000000000000`, etc. until they find the next letter in the key. They will keep repeating this process until they figure out all 15 characters of the API key and the attacker can now impersonate a legitimate client and gain access to any information available to that client.

The way around this attack is relatively simple; replace the algorithm that checks if the strings are equal with one that takes the same amount of time no matter which characters don’t match.

One implementation (in pseudo-code) is as follows:

```javascript
let indicator = 0
```

```javascript
for (each char in the string) {
  if (char is not equal to the corresponding char in the string on file) {
    change the value of indicator by one
  }
}
```

```javascript
return true if the value of indicator is 0 // i.e. it was never changed due to a mismatched character
```

```javascript
otherwise return false
```

As you can see, the function above goes through the entire string every time and only returns true or false at the end. It will, therefore, take the same amount of time no matter what string is passed in.

For those of you using Rails, ActiveRecord actually has a built-in method for this:  
`ActiveSupport::SecurityUtils.secure_compare(string1, string2)`  
This method incorporates the functionality above to compare both strings in constant time.

_This post oversimplifies many concepts. If security is an issue for your app (and if you handle client information, then it should be!), please educate yourself on the implications of different security vulnerabilities and attack vectors._

_You can learn more about timing attacks in the following links:_  
[_https://codahale.com/a-lesson-in-timing-attacks/_](https://codahale.com/a-lesson-in-timing-attacks/)  
[_https://thisdata.com/blog/timing-attacks-against-string-comparison/_](https://thisdata.com/blog/timing-attacks-against-string-comparison/)

