---
title: "Parenthetically Speaking 2"
date: 2017-12-10 02:55:03 +0000
permalink: /parenthetically-speaking-2-db6386eb9db3
header:
  teaser: /assets/images/posts/2017-12-10-2017-12-10_Parenthetically-Speaking-2-0.jpg
tags:
  - reflections
  - writing
  - interviewing
categories:
  - 
---

* * *

### Parenthetically Speaking&nbsp;2

#### Plus a brief intro to&nbsp;stacks

A few weeks ago [I wrote](https://blog.yechiel.me/parenthetically-speaking-a275f86c833e) about a standard interview question regarding checking a string to ensure all of the parentheses are correctly formatted, with each opening parenthesis having a matching closing parenthesis.

I provided the solution in the form of a JavaScript function that kept count of how many parentheses were open. If that count ever went less than zero (too many closing parentheses) or was above zero when the function reached the end of the string (too many open parentheses) the function would return false.

One shortcoming of my solution was that it only dealt with parentheses; it didn’t deal with other characters like brackets, curly brackets, and quotation marks. This blog post will expand the logic to include those characters.

The solution in this post is written in Ruby.

#### Defining The&nbsp;Problem.

As a reminder, here is the problem pasted from my previous post:

> Say you have a long string of text, with many parentheses, all nested within each other (for example a very long LISP program). You want to make sure that the sentence is formatted correctly and that every open parenthesis has a corresponding closing parenthesis.

The solution involved naming a variable called `counter` and then iterating through our string. For every open parenthesis in the string we incremented `counter` by 1, and for every closing parenthesis in the string, we decremented `counter` by one. This process allowed us to keep count of how many parentheses were open at any given time. If the counter went below zero that meant we just closed a parenthesis that didn’t have a corresponding opening parenthesis, and if the counter was above zero by the end of the string that meant there was an open parenthesis that we never closed.

Our challenge now is to tweak the function so it can keep track of open brackets, curly-brackets, and quotation marks.

At first glance, it seems like all we would have to do is have the counter keep track of those characters as well. If we think about it though, we will see that we can easily run into problems with strings like `"([)]"`; they have an equal number of opening and closing parentheses and brackets, but the bracket is opened inside of the parentheses and closes outside of it which is a no-no.

#### Stacks

The solution uses a data-structure called a stack.

To understand stacks, let’s think of this delicious stack:

![](/assets/images/posts/2017-12-10-2017-12-10_Parenthetically-Speaking-2-0.jpg)

If you are cooking pancakes for breakfast, you probably have a plate next to you. As each pancake is ready, you flip it out of the frying pan into the plate. Slowly slowly the pile of pancakes in the plate grows into a nice, neat stack. As your hungry family members drift into the kitchen following the heavenly smells, they see the pile of pancakes next to you, they then each come over and take a pancake off the top of the stack.

That’s the visual. The important part to notice here is that any interaction with the stack of pancakes happens at the top of the stack. The cook adds pancakes to the top of the pile while the family members take pancakes off of the top, so the pancake that got added last gets removed first.

![](/assets/images/posts/2017-12-10-2017-12-10_Parenthetically-Speaking-2-1.png)

Similarly, in computer science, a stack is a data structure where you can only add bits of data to the top of the stack, and then they can only be removed off the top, so whatever gets added last gets removed first (the technical term is LIFO or Last In First Out).

The technical term for adding and removing data from a stack is pushing and popping, so we `push` a bit of data to the top of the stack, and then later we `pop` it off the top when we need it.

So how will stacks help us balance our parentheses, brackets, and quotation marks? Simple, we will use a stack to help us keep track of the order of what we opened when.

Every time we encounter an opening parenthesis or bracket, we will `push` it into our stack. Then every time we encounter a closing parenthesis or bracket we will check what the last element in our stack is; if it matches the closing element we have (an opening bracket for a closing bracket for example), we will know the closing element is legit. We will then `pop` the last opening element off the top of the stack to signify that that opening element has been closed and then move on to the next element.

In Ruby that looks like this:

```ruby
OPENERS = ["(", "[", "{"]
CLOSERS = [")", "]", "}"]
VERSATILES = ["\"", "`"]
MATCHERS = {
  "(" => ")",
  "[" => "]",
  "{" => "}"
}
```

```ruby
def paren_checker(string)
```

```ruby
stack = []
```

elsif CLOSERS.include?(char)
```ruby
string.split("").each do |char|
  if OPENERS.include?(char)
    stack.push(char)

  elsif CLOSERS.include?(char)
```

```ruby
    if MATCHERS[stack.last] == char
      stack.pop
    else
      return false
    end
```

```ruby
  elsif VERSATILES.include?(char)
```

```ruby
    if stack.last == char
      stack.pop
    else
      stack.push(char)
    end

  end
```

```ruby
end
# Return true if the stack is empty (no opening parentheses left)
stack.size == 0
end
```

Let’s walk through that, line by line.

In the first three lines, we define arrays of what opening elements look like, closing elements, and elements like quotation marks that don’t have separate opening and closing elements.

In the 4th line, we define a hash table that will help us match opening elements to their closing elements.

Then we define a method called `paren_checker` that takes a string as an argument.

At the beginning of the method, we define our stack as an empty array.

We then split our string into an array of characters and iterate over the array.

For each character we run the following checks:

If the character is found in our array of opening elements, we `push` it into our stack.

If the character is found in our array of closing elements, we check; does it match the last opening element in our stack? If it does we `pop` the last opening element off the stack, if it doesn’t we break the loop because apparently someone is trying to close an element that hasn’t been opened yet (or has been opened outside the currently open element).

If the character is found in our array of versatile elements then we check; if the character does not match the last element in the stack we assume it’s an opening element and we push it into the stack, and if it does match the last element in the stack we assume it’s a closing element and pop the last element off the stack.

The one element I did not include in this method is the single quotation mark, being that it can also be used as an apostrophe which would throw off our calculations.

