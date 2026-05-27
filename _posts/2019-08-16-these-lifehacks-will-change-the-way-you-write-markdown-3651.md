---
title: "These lifehacks will change the way you write Markdown!"
date: 2019-08-16 00:26:46 +0000
permalink: /these-lifehacks-will-change-the-way-you-write-markdown-3651
tags:
  - writing
  - markdown
  - beginners
  - blogging
---

If you're a developer, chances are you've come across markdown editors before (whether you know it or not).

Markdown is supported by GitHub, DEV, many ticket trackers, most documentation and blogging platforms (cough.. cough... Medium...). Getting good with the markdown syntax will help you communicate more effectively as a developer.

There are lots of resources and cheat-sheets for getting started with the basics (like [this great gist](https://github.com/adam-p/markdown-here/wiki/Markdown-Here-Cheatsheet)). In this post I will share a few tips that I haven't seen too many people use or that aren't so well documented.

## Ordered Lists

The syntax for ordered lists is pretty simple:

```
1. Item one
2. Item two
3. another item
```

renders as:

1. Item one
2. Item two
3. another item

But have you ever written a long list and then realized you missed an item in the middle? Must have been really annoying to go back and insert it and then fix the numbers on all subsequent items...

Except, you don't have to! Markdown doesn't pay attention to the numbers, as long as you have a list of items with numbers in front of them, any numbers, it will render as an ordered list.

The following:

```
1. Item one
2. Item two
3. another item

1. Item one
1. Item two
1. another item

4. Item one
6. Item two
765. another item
```

All render as:

1. Item one
2. Item two
3. another item

My preferred style is to just use 1s in front of all of them, but if you prefer to have the actual numbers and find yourself needing to insert a new item say between item 7 and 8 you can just give the new item the number 7 as well and when the markdown gets rendered it will render properly with all of the numbers in order.

## Syntax Highlighting

*In the following section I've embedded snippets from gist, that is because there's a bug in the dev.to editor that doesn't allow escaping backticks properly.*

*I've [opened an issue](https://github.com/thepracticaldev/dev.to/issues/3648) on it in the dev.to repo. If any of the readers would like to take a crack at it feel free!*

Most people know that wrapping code snippets with three backticks like this:


<script src="https://gist.github.com/achasveachas/dfffd2cef6c5c61f887a3b7e3cc94c3d.js?file=gistfile1.md"></script>
<noscript><a href="https://gist.github.com/achasveachas/dfffd2cef6c5c61f887a3b7e3cc94c3d">View gist</a></noscript>

Will render it as a code snippet like this:

```
someCodeGoes("here")
```

You might also know that adding the name of the language your code is in like this:

<script src="https://gist.github.com/achasveachas/dfffd2cef6c5c61f887a3b7e3cc94c3d.js?file=gistfile2.md"></script>
<noscript><a href="https://gist.github.com/achasveachas/dfffd2cef6c5c61f887a3b7e3cc94c3d">View gist</a></noscript>

Will give you syntax highlighting like this:


```javascript
someCodeGoes("here")
```

But did you know that you can also put `diff` as a language, and when you do it will render any line that starts with a `-` in red and any line that starts with a `+` in green. 

So this:

<script src="https://gist.github.com/achasveachas/dfffd2cef6c5c61f887a3b7e3cc94c3d.js?file=gistfile3.md"></script>
<noscript><a href="https://gist.github.com/achasveachas/dfffd2cef6c5c61f887a3b7e3cc94c3d">View gist</a></noscript>

Will render like this:

```diff
    someCodeGoes(here) {
-     oldCode()
+     newCode()
      someMore(code)
    }
```

I found this particularly useful when writing tutorials and there are steps with only small code changes. It can sometimes be hard for readers to realize what changed, using diffs to highlight the difference can make it a lot easier!

## Escaping Backticks; The Lifehack That Wasn't 

The next lifehack involves how to escape backticks and other reserved characters in Markdown, but due to the bug mentioned in the beginning of the last section I'll have to leave that for another time :(

If you would like to see how it's done, check out the [gist I embedded above](https://gist.github.com/achasveachas/dfffd2cef6c5c61f887a3b7e3cc94c3d) and click on the "Raw" button to see how I did it.

I hope you found these useful!

Now get to writing that documentation you've been putting off!