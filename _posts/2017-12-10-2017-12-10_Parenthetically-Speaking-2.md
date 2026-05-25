---
title: "Parenthetically Speaking 2"
date: 2017-12-10 02:55:03 +0000
permalink: /parenthetically-speaking-2-db6386eb9db3
header:
  teaser: /assets/images/posts/2017-12-10-2017-12-10_Parenthetically-Speaking-2-0.
tags:
  - 
categories:
  - 
---

<section data-field="body" class="e-content">
<section name="76f8" class="section section--body section--first section--last"><div class="section-divider"><hr class="section-divider"></div>
<div class="section-content"><div class="section-inner sectionLayout--insetColumn">
<h3 name="f6e6" id="f6e6" class="graf graf--h3 graf--leading graf--title">Parenthetically Speaking 2</h3>
<h4 name="b43d" id="b43d" class="graf graf--h4 graf-after--h3 graf--subtitle">Plus a brief intro to stacks</h4>
<p name="a9a6" id="a9a6" class="graf graf--p graf-after--h4">A few weeks ago <a href="https://blog.yechiel.me/parenthetically-speaking-a275f86c833e" data-href="https://blog.yechiel.me/parenthetically-speaking-a275f86c833e" class="markup--anchor markup--p-anchor" rel="noopener" target="_blank">I wrote</a> about a standard interview question regarding checking a string to ensure all of the parentheses are correctly formatted, with each opening parenthesis having a matching closing parenthesis.</p>
<p name="b2a2" id="b2a2" class="graf graf--p graf-after--p">I provided the solution in the form of a JavaScript function that kept count of how many parentheses were open. If that count ever went less than zero (too many closing parentheses) or was above zero when the function reached the end of the string (too many open parentheses) the function would return false.</p>
<p name="02a9" id="02a9" class="graf graf--p graf-after--p">One shortcoming of my solution was that it only dealt with parentheses; it didn’t deal with other characters like brackets, curly brackets, and quotation marks. This blog post will expand the logic to include those characters.</p>
<p name="06df" id="06df" class="graf graf--p graf-after--p">The solution in this post is written in Ruby.</p>
<h4 name="1cd1" id="1cd1" class="graf graf--h4 graf-after--p">Defining The Problem.</h4>
<p name="317d" id="317d" class="graf graf--p graf-after--h4">As a reminder, here is the problem pasted from my previous post:</p>
<blockquote name="216c" id="216c" class="graf graf--pullquote graf-after--p">Say you have a long string of text, with many parentheses, all nested within each other (for example a very long LISP program). You want to make sure that the sentence is formatted correctly and that every open parenthesis has a corresponding closing parenthesis.</blockquote>
<p name="a802" id="a802" class="graf graf--p graf-after--pullquote">The solution involved naming a variable called <code class="markup--code markup--p-code">counter</code> and then iterating through our string. For every open parenthesis in the string we incremented <code class="markup--code markup--p-code">counter</code> by 1, and for every closing parenthesis in the string, we decremented <code class="markup--code markup--p-code">counter</code> by one. This process allowed us to keep count of how many parentheses were open at any given time. If the counter went below zero that meant we just closed a parenthesis that didn’t have a corresponding opening parenthesis, and if the counter was above zero by the end of the string that meant there was an open parenthesis that we never closed.</p>
<p name="6404" id="6404" class="graf graf--p graf-after--p">Our challenge now is to tweak the function so it can keep track of open brackets, curly-brackets, and quotation marks.</p>
<p name="839c" id="839c" class="graf graf--p graf-after--p">At first glance, it seems like all we would have to do is have the counter keep track of those characters as well. If we think about it though, we will see that we can easily run into problems with strings like <code class="markup--code markup--p-code">"([)]"</code>; they have an equal number of opening and closing parentheses and brackets, but the bracket is opened inside of the parentheses and closes outside of it which is a no-no.</p>
<h4 name="6e90" id="6e90" class="graf graf--h4 graf-after--p">Stacks</h4>
<p name="1994" id="1994" class="graf graf--p graf-after--h4">The solution uses a data-structure called a stack.</p>
<p name="15e1" id="15e1" class="graf graf--p graf-after--p">To understand stacks, let’s think of this delicious stack:</p>
<figure name="d19d" id="d19d" class="graf graf--figure graf-after--p"><img class="graf-image" data-image-id="0*IL4aD7k5ncyn-gYO." data-width="590" data-height="590" data-is-featured="true" src="/assets/images/posts/2017-12-10-2017-12-10_Parenthetically-Speaking-2-0."></figure><p name="ff5d" id="ff5d" class="graf graf--p graf-after--figure">If you are cooking pancakes for breakfast, you probably have a plate next to you. As each pancake is ready, you flip it out of the frying pan into the plate. Slowly slowly the pile of pancakes in the plate grows into a nice, neat stack. As your hungry family members drift into the kitchen following the heavenly smells, they see the pile of pancakes next to you, they then each come over and take a pancake off the top of the stack.</p>
<p name="2ceb" id="2ceb" class="graf graf--p graf-after--p">That’s the visual. The important part to notice here is that any interaction with the stack of pancakes happens at the top of the stack. The cook adds pancakes to the top of the pile while the family members take pancakes off of the top, so the pancake that got added last gets removed first.</p>
<figure name="d284" id="d284" class="graf graf--figure graf-after--p"><img class="graf-image" data-image-id="0*6s_vEA48GbnFkRGw.png" data-width="546" data-height="284" src="/assets/images/posts/2017-12-10-2017-12-10_Parenthetically-Speaking-2-1.png"></figure><p name="a639" id="a639" class="graf graf--p graf-after--figure">Similarly, in computer science, a stack is a data structure where you can only add bits of data to the top of the stack, and then they can only be removed off the top, so whatever gets added last gets removed first (the technical term is LIFO or Last In First Out).</p>
<p name="b422" id="b422" class="graf graf--p graf-after--p">The technical term for adding and removing data from a stack is pushing and popping, so we <code class="markup--code markup--p-code">push</code> a bit of data to the top of the stack, and then later we <code class="markup--code markup--p-code">pop</code> it off the top when we need it.</p>
<p name="b58a" id="b58a" class="graf graf--p graf-after--p">So how will stacks help us balance our parentheses, brackets, and quotation marks? Simple, we will use a stack to help us keep track of the order of what we opened when.</p>
<p name="3f65" id="3f65" class="graf graf--p graf-after--p">Every time we encounter an opening parenthesis or bracket, we will <code class="markup--code markup--p-code">push</code> it into our stack. Then every time we encounter a closing parenthesis or bracket we will check what the last element in our stack is; if it matches the closing element we have (an opening bracket for a closing bracket for example), we will know the closing element is legit. We will then <code class="markup--code markup--p-code">pop</code> the last opening element off the top of the stack to signify that that opening element has been closed and then move on to the next element.</p>
<p name="8131" id="8131" class="graf graf--p graf-after--p">In Ruby that looks like this:</p>
<pre name="b092" id="b092" class="graf graf--pre graf-after--p">OPENERS = ["(", "[", "{"]<br>CLOSERS = [")", "]", "}"]<br>VERSATILES = ["\"", "`"]<br>MATCHERS = {<br> "(" =&gt; ")",<br> "[" =&gt; "]",<br> "{" =&gt; "}"<br>}</pre>
<pre name="2efa" id="2efa" class="graf graf--pre graf-after--pre">def paren_checker(string)</pre>
<pre name="d72d" id="d72d" class="graf graf--pre graf-after--pre"> stack = []</pre>
<pre name="58ca" id="58ca" class="graf graf--pre graf-after--pre"> string.split("").each do |char|<br> if OPENERS.include?(char)<br> stack.push(char)<br> <br> elsif CLOSERS.include?(char)</pre>
<pre name="3376" id="3376" class="graf graf--pre graf-after--pre"> if MATCHERS[stack.last] == char <br> stack.pop<br> else<br> return false<br> end</pre>
<pre name="068d" id="068d" class="graf graf--pre graf-after--pre"> elsif VERSATILES.include?(char)</pre>
<pre name="9628" id="9628" class="graf graf--pre graf-after--pre"> if stack.last == char<br> stack.pop<br> else<br> stack.push(char)<br> end <br> <br> end</pre>
<pre name="e35c" id="e35c" class="graf graf--pre graf-after--pre"> end<br> # Return true if the stack is empty (no opening parentheses left)<br> stack.size == 0<br>end</pre>
<p name="ad79" id="ad79" class="graf graf--p graf-after--pre">Let’s walk through that, line by line.</p>
<p name="7df0" id="7df0" class="graf graf--p graf-after--p">In the first three lines, we define arrays of what opening elements look like, closing elements, and elements like quotation marks that don’t have separate opening and closing elements.</p>
<p name="abd4" id="abd4" class="graf graf--p graf-after--p">In the 4th line, we define a hash table that will help us match opening elements to their closing elements.</p>
<p name="0d85" id="0d85" class="graf graf--p graf-after--p">Then we define a method called <code class="markup--code markup--p-code">paren_checker</code> that takes a string as an argument.</p>
<p name="bcdf" id="bcdf" class="graf graf--p graf-after--p">At the beginning of the method, we define our stack as an empty array.</p>
<p name="12bf" id="12bf" class="graf graf--p graf-after--p">We then split our string into an array of characters and iterate over the array.</p>
<p name="8feb" id="8feb" class="graf graf--p graf-after--p">For each character we run the following checks:</p>
<p name="ea2d" id="ea2d" class="graf graf--p graf-after--p">If the character is found in our array of opening elements, we <code class="markup--code markup--p-code">push</code> it into our stack.</p>
<p name="b36a" id="b36a" class="graf graf--p graf-after--p">If the character is found in our array of closing elements, we check; does it match the last opening element in our stack? If it does we <code class="markup--code markup--p-code">pop</code> the last opening element off the stack, if it doesn’t we break the loop because apparently someone is trying to close an element that hasn’t been opened yet (or has been opened outside the currently open element).</p>
<p name="1e13" id="1e13" class="graf graf--p graf-after--p">If the character is found in our array of versatile elements then we check; if the character does not match the last element in the stack we assume it’s an opening element and we push it into the stack, and if it does match the last element in the stack we assume it’s a closing element and pop the last element off the stack.</p>
<p name="8899" id="8899" class="graf graf--p graf-after--p graf--trailing">The one element I did not include in this method is the single quotation mark, being that it can also be used as an apostrophe which would throw off our calculations.</p>
</div></div></section>
</section>