---
title: "Parenthetically Speaking"
date: 2017-10-27 00:50:46 +0000
permalink: /parenthetically-speaking-a275f86c833e
header:
  teaser: /assets/images/posts/2017-10-27-2017-10-27_Parenthetically-Speaking-0.jpeg
tags:
  - 
categories:
  - 
---

* * *

### Parenthetically Speaking

I’ve [blogged in the past](https://blog.yechiel.me/get-your-fizz-buzz-on-543f2a327a9d) about [interesting questions](https://blog.yechiel.me/welcome-to-the-mvc-restaurant-fb1709047914) I got asked during interviews, and [how to answer them](https://blog.yechiel.me/welcome-to-the-mvc-restaurant-fb1709047914).

In this post, I want to discuss a popular interview question, and how to approach answering it. The reason I want to talk about this specific question is that the algorithm used to solve it is so similar to how a human would approach the same problem.

#### The Question

The question goes as follows:

Say you have a long string of text, with many parentheses, all nested within each other (for example a very long LISP program). You want to make sure that the sentence is formatted correctly and that every open parenthesis has a corresponding closing parenthesis.

![](/assets/images/posts/2017-10-27-2017-10-27_Parenthetically-Speaking-0.jpeg)

Before I write the solution in code, let’s think a bit about how we, as humans, would approach this problem.

A reasonable approach would be to count all of the opening parentheses and all of the closing parentheses and make sure the numbers are the same.

Let’s try that in JavaScript:

```javascript
function parenthesesChecker(text) {
```

```javascript
var open = 0
var close = 0
```

```javascript
for(i = 0; i < text.length; i ++) {
  if(text[i] === "(") {
    open += 1
  } else if(text[i] === ")") {
    close += 1
  }
}
```

```javascript
return open === close
}
```

Let’s go through that code line by line.

First thing we do is, we declare two variables named `open` and `close` and we set their value to 0.

Then we iterate over the text, and for every open parenthesis we find we increment the value of `open` by 1, and for every closing parenthesis, we increment the value of `close`.

Finally, we check if the values for `open` and `close` are the same. If they are we return `true`, otherwise we return `false`.

Simple.

#### Does It&nbsp;Work?

Let’s check out algorithm against a few test strings to make sure it works.

Let’s start with the simplest one: `"()"`

We have one open parenthesis and one closed one, that returns `true`. Perfect.

`"()()()"` returns `true` as well.

Let’s try some nested parentheses: `"((()))"`, `"(()())"`, `"(()(()))"` all return `true`.

Now let’s look at some bad strings and see if they all return `false`: `"("`, `"(()"`, `"(())()(("` all return `false`, as they should.

But then we run into some problems: `")("` `"(()))("` return `true` even though they are poorly formatted. There is an equal number of open and closed parentheses, but they either start with a closing parenthesis or end with an opening parenthesis.

We could add an if statement to look at the first and last parentheses to check, but what about this case: `"())(()"`? The first and last parentheses are ok, there’s an equal number of opening and closing parentheses, but it’s still a bad string.

#### We Need A New Approach.

Let’s think again, how would we as humans look at this issue? A better way to do it would be, instead of counting open and closed parentheses, to keep track of how many parentheses remain open. So we go through the sentence, every time we get to an open parenthesis, we say “that’s one open,” “that’s two open,” etc. and every time we reach a closing parenthesis we count down: “that’s one open,” “no open,” etc. If we ever get below zero, we know we are in trouble, and if we reach the end with parentheses still open we know we are in trouble as well.

How would that look in JavaScript? Very similar to our last function:

```javascript
function parenthesesChecker(text) {
```

```javascript
var open = 0
```

```javascript
for(i = 0; i < text.length; i ++) {
  if(text[i] === "(") {
    open += 1
  } else if(text[i] === ")") {
    open -= 1
  }
  if(open < 0)
    return false
}
```

```javascript
return open === 0
}
```

The only difference is that instead of tracking two variables, `open` and `close`, we only track one variable named `open`. When we reach an open parenthesis, we increment our `open` variable, and when we reach a closing parenthesis, we decrement it. If the value of `open` ever goes below 0 we return `false` automatically, and if at the end it’s anything OTHER than 0 we return `false` as well.

This solution seems to work for all cases. If I missed anything, I’m sure you’ll point it out in the comments.

