---
title: "What’s The Point Of Pointers?"
date: 2019-02-14 18:10:40 +0000
permalink: /whats-the-point-of-pointers-2dd3b64ec52a
header:
  teaser: /assets/images/posts/2019-02-14-2019-02-14_What-s-The-Point-Of-Pointers--0.png
tags:
  - 
categories:
  - 
---

* * *

### What’s The Point Of Pointers?

_This Dvar Torah was originally published in Torah && Tech, the weekly newsletter I publish together with my good friend_ [_Ben Greenberg_](https://medium.com/u/8b0c7fbdbada)_. To get the weekly issue delivered straight to your inbox click_ [_here_](https://mailchi.mp/f78e9b44f28d/torahandtech)_._

![](/assets/images/posts/2019-02-14-2019-02-14_What-s-The-Point-Of-Pointers--0.png)

_Source: XKCD — Pointers_
{: .image-caption}

This week’s Torah portion, _Tetzaveh_, has the unusual distinction of being the only portion in the Torah, starting with his birth in _Shemot_, where Moshe’s name is not mentioned even once.

The 13th-century commentary, the _Ba’al Haturim_, gives an interesting explanation. After the Jews sinned with the Golden Calf, Moshe was begging G-D to forgive them, saying “Now, if You will forgive their sin [well and good]; but if not, erase me from the book which You have written!” (Shemot 32:32).

The _Ba’al Haturim_ goes on to explain: “Although this exclamation was conditional upon God’s refusal to forgive the people for the sin of the Calf, the curse of a scholar is fulfilled in some way, even when made conditionally.” So even though G-D ended up forgiving the Jewish people and didn’t have to go through with Moshe’s “threat,” he nevertheless went through with it to a smaller extent by removing Moses’s name from one portion of the Torah.

The Lubavitcher Rebbe _OBM_ used to point out a, seemingly ironic, fact. Even though G-D removed Moshe’s name from the Torah portion, Moshe himself was not. The portion of Tetzaveh contains numerous references to Moshe in the first person, starting with the very first verse, “And **you** shall instruct the Jewish People…”

In a certain sense, the Rebbe explained, Moshe’s presence in _Tetzaveh_ is actually felt much stronger. Where a name is external, only used by others to address us, “you” refers to your essence. In other words, in “erasing” Moshe’s name from the Torah, G-D wrote in Moshe “himself.”

Though it may seem counter to Moshe’s intent, it was actually pretty fitting. In Moshe’s declaration “erase me from the book which You have written” Moshe revealed his true essence as the ultimate leader, willing to put his life’s work on the line to save his people.

What does all of this have to do with tech? I’m ( **Yechiel** ) glad you asked (and I would like to apologize if this part gets more technical than previous newsletters).

Being relatively new to the Go language, one of the features that confused me a lot at first was the idea of pointers. Coming from Ruby and Python where pointers don’t exist I had a hard time wrapping my head around them and why they were necessary. Why is a pointer to a location in memory where a value is stored any different than a variable that holds that value? I believe the idea above, about the difference between Moshe’s name and Moshe himself, can help us understand.

Consider the following code sample:

```go
func increment(num int) { num+=1}
```

```go
func main(){ var x = 1 increment(x) println(x)}
```

[Playground link](https://play.golang.org/p/fN1qIZD8Ycw)

We have a function `increment()` that takes a number and increments it by 1. We then take a variable `x`, assign it to the number 1, we call `increment` on `x`and then print it. The result is that gets printed is not 2 (the result of incrementing `x` by 1); instead, 1 gets printed.

The reason for this behavior is that when we call `increment(x)`, the increment function makes a copy of the value of `x`, assigns it to a new variable in its own scope, and increments **that**. The original `x` remains unchanged.

If we wanted `increment()` to increment the actual value of `x` we could modify our code as follows:

```go
func increment(num *int) { *num+=1}
```

```go
func main() { var x = 1 increment(&x) println(x)}
```

[Playground link](https://play.golang.org/p/dox_cvSjuQA)

Our new `increment()` doesn't take a number as an argument, it takes a pointer to a number, an address in memory where that number is stored. And when `increment()` increments the number, it increments the number at that location in memory. Running the second code snippet gives us 2 as we expect. All because we pointed at the number itself instead of at its value.

Sometimes, in life, we have to know where to point to and what defines the mark we leave around us and what actually defines us, in our essence.

Shabbat Shalom,

