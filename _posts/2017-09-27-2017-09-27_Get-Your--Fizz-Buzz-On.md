---
title: "Get Your (Fizz)Buzz On"
date: 2017-09-27 02:35:39 +0000
permalink: /2017-09-27_Get-Your--Fizz-Buzz-On-543f2a327a9d
header:
  teaser: /assets/images/posts/2017-09-27-2017-09-27_Get-Your--Fizz-Buzz-On-0.jpg
tags:
  - 
categories:
  - 
---

<section data-field="body" class="e-content">
<section name="143d" class="section section--body section--first section--last"><div class="section-divider"><hr class="section-divider"></div>
<div class="section-content"><div class="section-inner sectionLayout--insetColumn">
<h3 name="9cf3" id="9cf3" class="graf graf--h3 graf--leading graf--title">Get Your (Fizz)Buzz On</h3>
<h4 name="1012" id="1012" class="graf graf--h4 graf-after--h3 graf--subtitle">The Evolution Of FizzBuzz</h4>
<p name="e6a6" id="e6a6" class="graf graf--p graf-after--h4">Learning to code was full of learning moments. One that I look back upon fondly was when I did the Flatiron lesson on FizzBuzz. That memory has been greatly reinforced when Flatiron hired me as a Technical Coach; FizzBuzz was one of my favorite labs to help new students with.</p>
<p name="8e4b" id="8e4b" class="graf graf--p graf-after--p">I will explain why the process of learning (and then teaching) FizzBuzz stood out so much, but first a word on what FizzBuzz is.</p>
<h4 name="c174" id="c174" class="graf graf--h4 graf-after--p">What The Fizz?</h4>
<p name="023b" id="023b" class="graf graf--p graf-after--h4">I know the first thing that comes to your mind when you hear FizzBuzz is probably something like this:</p>
<figure name="1d8c" id="1d8c" class="graf graf--figure graf-after--p"><img class="graf-image" data-image-id="0*7QUZQje9UrsKHNVv.jpg" data-width="500" data-height="500" src="/assets/images/posts/2017-09-27-2017-09-27_Get-Your--Fizz-Buzz-On-0.jpg"><figcaption class="imageCaption">Fizzy Buzzy Was A Hare</figcaption></figure><p name="94c4" id="94c4" class="graf graf--p graf-after--figure">FizzBuzz is a small game that interviewers use to weed out the extraordinarily bad coders from the ones who don’t know how to code at all. It’s a fairly simple problem, which anyone with the most rudimentary knowledge of how computers work should be able to solve, yet apparently, there are enough applicants for developer positions who can’t solve it to warrant its use in interviewing.</p>
<p name="65eb" id="65eb" class="graf graf--p graf-after--p">The problem is as follows:</p>
<blockquote name="d81f" id="d81f" class="graf graf--blockquote graf-after--p">Write a program that prints the numbers 1–100, but for every number that is a multiple of three print the word <code class="markup--code markup--blockquote-code">Fizz</code>, for every number that’s a multiple of five print <code class="markup--code markup--blockquote-code">Buzz</code>, and for every number that’s a multiple of both three and five print <code class="markup--code markup--blockquote-code">FizzBuzz</code>. So the output for the first 15 numbers would look like this:<br><code class="markup--code markup--blockquote-code">1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz…</code>
</blockquote>
<p name="40da" id="40da" class="graf graf--p graf-after--blockquote">In this post, I will be showing the solutions in Ruby, just because I like Ruby, and I think it’s the prettiest language. But most of the concepts can be ported to any language.</p>
<h4 name="5fff" id="5fff" class="graf graf--h4 graf-after--p">What Doesn’t Work</h4>
<p name="da82" id="da82" class="graf graf--p graf-after--h4">To explain the beauty of FizzBuzz, and why I love teaching it to new coders, let me demonstrate the first knee-jerk solution a new coder might come up with.</p>
<pre name="55c2" id="55c2" class="graf graf--pre graf-after--p">(1..100).each do |i|<br> if i % 3 == 0<br> puts "Fizz"<br> elsif i % 5 == 0<br> puts "Buzz"<br> elsif i % 3 == 0 &amp;&amp; i % 5 == 0<br> puts "FizzBuzz"<br> else<br> puts i<br> end<br>end</pre>
<p name="1c28" id="1c28" class="graf graf--p graf-after--pre">And in English:</p>
<blockquote name="0440" id="0440" class="graf graf--blockquote graf-after--p">For each number in the range of 1–100 check the following: if the number can be divided cleanly into three print <code class="markup--code markup--blockquote-code">Fizz</code>, otherwise, if it can be divided cleanly into five print <code class="markup--code markup--blockquote-code">Buzz</code>, otherwise, check if it can be divided cleanly into 3 AND 5 print <code class="markup--code markup--blockquote-code">FizzBuzz</code>.</blockquote>
<p name="f737" id="f737" class="graf graf--p graf-after--blockquote">Seems pretty straightforward, no? If you gave those instructions to a human, you would be understandably annoyed if they messed it up. But apparently, that’s not clear enough for a computer. If you give the above code snippet to a computer, you would see a nice list of numbers, with plenty of Fizzes and Buzzes mixed in, but not one FizzBuzz. To understand why, we have to look at the difference between how humans look at instructions, and how computers do.</p>
<p name="49d1" id="49d1" class="graf graf--p graf-after--p">When a human looks at a block of code, we try to look at it as a whole entity. What is this code doing? What is it trying to accomplish? Why was it written? Computers don’t have that big-picture view; a computer will just analyze the code line by line and execute the instructions given.</p>
<p name="1fc5" id="1fc5" class="graf graf--p graf-after--p">Let’s try to look at the code above through the eyes of a computer.</p>
<p name="715b" id="715b" class="graf graf--p graf-after--p">First, the computer looks at the number 1. It takes it through the steps we outlined for it. Does it divide into 3? No. Okay, do nothing. Next, does it divide into 5? No. Okay, do nothing again. Next, does it divide into 3 and 5? No. Okay, do nothing. Next, print the number, got it.</p>
<p name="9094" id="9094" class="graf graf--p graf-after--p">The computer then repeats the process with number 2; it looks pretty much the same.</p>
<p name="4efd" id="4efd" class="graf graf--p graf-after--p">By number 3 the process is different. The computer tries dividing it into three; it works! Great! Let’s print Fizz. Next number, etc.</p>
<p name="a844" id="a844" class="graf graf--p graf-after--p">Now let’s take a look at what happens when we reach number 15. Remember, the computer only analyzes one line at a time, so the computer tries dividing 15 into 3, it works, the computer is happy, it prints Fizz and then goes right on to the next number, never reaching the line where its told to try dividing into 3 AND 5.</p>
<h4 name="3db9" id="3db9" class="graf graf--h4 graf-after--p">The Solution</h4>
<p name="05dc" id="05dc" class="graf graf--p graf-after--h4">Fortunately, this can be fixed by simply moving the last condition to the front, so that the computer will try to divide the number into 3 and five before it tries them separately, like this:</p>
<pre name="ea1a" id="ea1a" class="graf graf--pre graf-after--p">(1..100).each do |i|</pre>
<pre name="9bb9" id="9bb9" class="graf graf--pre graf-after--pre"> if i % 3 == 0 &amp;&amp; i % 5 == 0<br> puts "FizzBuzz"<br> elsif i % 3 == 0<br> puts "Fizz"<br> elsif i % 5 == 0<br> puts "Buzz"<br> else<br> puts i<br> end<br>end</pre>
<h4 name="3f77" id="3f77" class="graf graf--h4 graf-after--pre">The More The Fuzzier</h4>
<p name="9a56" id="9a56" class="graf graf--p graf-after--h4">Now, as mentioned, FizzBuzz is a beginners problem, anyone who spent some time coding should be able to solve it without much thought. But in programming, there is never only one way to solve a problem.</p>
<figure name="fd52" id="fd52" class="graf graf--figure graf-after--p"><img class="graf-image" data-image-id="0*IruB2296CkQ2aEDK.gif" data-width="650" data-height="346" src="/assets/images/posts/2017-09-27-2017-09-27_Get-Your--Fizz-Buzz-On-1.gif"><figcaption class="imageCaption">All this talk of Fizz and Buzz is really giving me a lift…</figcaption></figure><p name="68e8" id="68e8" class="graf graf--p graf-after--figure">I would like to share a different way of solving FizzBuzz, one that looks a lot prettier in my opinion. This solution takes a slightly different approach:</p>
<pre name="de9e" id="de9e" class="graf graf--pre graf-after--p">(1..100).each do |i|<br> <br> output = ""<br> output += "Fizz" if i % 3 == 0<br> output += "Buzz" if i % 5 == 0<br> output = i if output.empty?<br> <br> puts output<br>end</pre>
<p name="6282" id="6282" class="graf graf--p graf-after--pre">In English:</p>
<blockquote name="9b15" id="9b15" class="graf graf--blockquote graf-after--p">For each number in the range of 1–100 we start with an empty string (<code class="markup--code markup--blockquote-code">“”</code>), we then add <code class="markup--code markup--blockquote-code">Fizz</code> to the string if the number is divisible by 3, we add <code class="markup--code markup--blockquote-code">Buzz</code> to the string if the number is divisible by 5, if the string is still empty by this time (which will only happen if the number is not divisible by 3 or by 5) we will swap the empty string out for the number.</blockquote>
<p name="9e37" id="9e37" class="graf graf--p graf-after--blockquote">Notice how in this approach, we never check if the number is divisible by 3 AND 5, we just add Buzz to the existing string, which would be an empty string if the number is not divisible by three, and a string equaling Fizz if it is divisible by three.</p>
<h4 name="c016" id="c016" class="graf graf--h4 graf-after--p">But Does It Scale?</h4>
<p name="eae1" id="eae1" class="graf graf--p graf-after--h4">So now we solved the problem, but as programmers, we always try to improve.</p>
<p name="ef42" id="ef42" class="graf graf--p graf-after--p">Our solution works, the problem is it doesn’t scale really well. Suppose we wanted to do the same thing but for all the numbers between 1 and 50? 500? 5000? We would have to write a separate FizzBuzz program for each of those.</p>
<p name="b19f" id="b19f" class="graf graf--p graf-after--p">The solution would, of course, be, to write a <code class="markup--code markup--p-code">FizzBuzz</code> method that we can provide with a number, and have it run the FizzBuzz logic on every number from one through the number we provide. We can even give it a default argument so that if we don’t provide a number it will print FizzBuzz for 1–100.</p>
<p name="299b" id="299b" class="graf graf--p graf-after--p">That would look like this:</p>
<pre name="e6fb" id="e6fb" class="graf graf--pre graf-after--p">def fizzbuzz(num = 100)<br> (1..num).each do |i|<br> <br> output = ""<br> output += "Fizz" if i % 3 == 0<br> output += "Buzz" if i % 5 == 0<br> output = i if output.empty?<br> <br> puts output<br> end<br>end</pre>
<p name="090d" id="090d" class="graf graf--p graf-after--pre graf--trailing">There are many more ways to solve FizzBuzz in Ruby (and in every other language), feel free to add your favorite in the comments.</p>
</div></div></section>
</section>