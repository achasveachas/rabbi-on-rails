---
title: "Parenthetically Speaking"
date: 2017-10-27 00:50:46 +0000
permalink: /2017-10-27_Parenthetically-Speaking-a275f86c833e
header:
  teaser: /assets/images/posts/2017-10-27-2017-10-27_Parenthetically-Speaking-0.jpeg
tags:
  - 
categories:
  - 
---

<section data-field="body" class="e-content">
<section name="18fd" class="section section--body section--first section--last"><div class="section-divider"><hr class="section-divider"></div>
<div class="section-content"><div class="section-inner sectionLayout--insetColumn">
<h3 name="99a3" id="99a3" class="graf graf--h3 graf--leading graf--title">Parenthetically Speaking</h3>
<p name="b4c7" id="b4c7" class="graf graf--p graf-after--h3">I’ve <a href="https://blog.yechiel.me/get-your-fizz-buzz-on-543f2a327a9d" data-href="https://blog.yechiel.me/get-your-fizz-buzz-on-543f2a327a9d" class="markup--anchor markup--p-anchor" rel="noopener" target="_blank">blogged in the past</a> about <a href="https://blog.yechiel.me/welcome-to-the-mvc-restaurant-fb1709047914" data-href="https://blog.yechiel.me/welcome-to-the-mvc-restaurant-fb1709047914" class="markup--anchor markup--p-anchor" rel="noopener" target="_blank">interesting questions</a> I got asked during interviews, and <a href="https://blog.yechiel.me/welcome-to-the-mvc-restaurant-fb1709047914" data-href="https://blog.yechiel.me/welcome-to-the-mvc-restaurant-fb1709047914" class="markup--anchor markup--p-anchor" rel="noopener" target="_blank">how to answer them</a>.</p>
<p name="c8cb" id="c8cb" class="graf graf--p graf-after--p">In this post, I want to discuss a popular interview question, and how to approach answering it. The reason I want to talk about this specific question is that the algorithm used to solve it is so similar to how a human would approach the same problem.</p>
<h4 name="8115" id="8115" class="graf graf--h4 graf-after--p">The Question</h4>
<p name="9f49" id="9f49" class="graf graf--p graf-after--h4">The question goes as follows:</p>
<p name="c96d" id="c96d" class="graf graf--p graf-after--p">Say you have a long string of text, with many parentheses, all nested within each other (for example a very long LISP program). You want to make sure that the sentence is formatted correctly and that every open parenthesis has a corresponding closing parenthesis.</p>
<figure name="b7d5" id="b7d5" class="graf graf--figure graf-after--p"><img class="graf-image" data-image-id="1*cSQ6S1Vus-HTTUrM04ZLwQ.jpeg" data-width="710" data-height="473" src="/assets/images/posts/2017-10-27-2017-10-27_Parenthetically-Speaking-0.jpeg"></figure><p name="876b" id="876b" class="graf graf--p graf-after--figure">Before I write the solution in code, let’s think a bit about how we, as humans, would approach this problem.</p>
<p name="0a11" id="0a11" class="graf graf--p graf-after--p">A reasonable approach would be to count all of the opening parentheses and all of the closing parentheses and make sure the numbers are the same.</p>
<p name="01fd" id="01fd" class="graf graf--p graf-after--p">Let’s try that in JavaScript:</p>
<pre name="8f58" id="8f58" class="graf graf--pre graf-after--p">function parenthesesChecker(text) {</pre>
<pre name="a8e8" id="a8e8" class="graf graf--pre graf-after--pre"> var open = 0<br> var close = 0</pre>
<pre name="ff4e" id="ff4e" class="graf graf--pre graf-after--pre"> for(i = 0; i &lt; text.length; i ++) {<br> if(text[i] === "(") {<br> open += 1<br> } else if(text[i] === ")") {<br> close += 1<br> }<br> }</pre>
<pre name="bfa8" id="bfa8" class="graf graf--pre graf-after--pre"> return open === close<br>}</pre>
<p name="fb80" id="fb80" class="graf graf--p graf-after--pre">Let’s go through that code line by line.</p>
<p name="e709" id="e709" class="graf graf--p graf-after--p">First thing we do is, we declare two variables named <code class="markup--code markup--p-code">open</code> and <code class="markup--code markup--p-code">close</code> and we set their value to 0.</p>
<p name="1e8e" id="1e8e" class="graf graf--p graf-after--p">Then we iterate over the text, and for every open parenthesis we find we increment the value of <code class="markup--code markup--p-code">open</code> by 1, and for every closing parenthesis, we increment the value of <code class="markup--code markup--p-code">close</code>.</p>
<p name="4bc0" id="4bc0" class="graf graf--p graf-after--p">Finally, we check if the values for <code class="markup--code markup--p-code">open</code> and <code class="markup--code markup--p-code">close</code> are the same. If they are we return <code class="markup--code markup--p-code">true</code>, otherwise we return <code class="markup--code markup--p-code">false</code>.</p>
<p name="a016" id="a016" class="graf graf--p graf-after--p">Simple.</p>
<h4 name="f0fe" id="f0fe" class="graf graf--h4 graf-after--p">Does It Work?</h4>
<p name="ae5a" id="ae5a" class="graf graf--p graf-after--h4">Let’s check out algorithm against a few test strings to make sure it works.</p>
<p name="cba6" id="cba6" class="graf graf--p graf-after--p">Let’s start with the simplest one: <code class="markup--code markup--p-code">"()"</code></p>
<p name="1fab" id="1fab" class="graf graf--p graf-after--p">We have one open parenthesis and one closed one, that returns <code class="markup--code markup--p-code">true</code>. Perfect.</p>
<p name="b3cc" id="b3cc" class="graf graf--p graf-after--p"><code class="markup--code markup--p-code">"()()()"</code> returns <code class="markup--code markup--p-code">true</code> as well.</p>
<p name="17ad" id="17ad" class="graf graf--p graf-after--p">Let’s try some nested parentheses: <code class="markup--code markup--p-code">"((()))"</code>, <code class="markup--code markup--p-code">"(()())"</code>, <code class="markup--code markup--p-code">"(()(()))"</code> all return <code class="markup--code markup--p-code">true</code>.</p>
<p name="599f" id="599f" class="graf graf--p graf-after--p">Now let’s look at some bad strings and see if they all return <code class="markup--code markup--p-code">false</code>: <code class="markup--code markup--p-code">"("</code>, <code class="markup--code markup--p-code">"(()"</code>, <code class="markup--code markup--p-code">"(())()(("</code> all return <code class="markup--code markup--p-code">false</code>, as they should.</p>
<p name="307a" id="307a" class="graf graf--p graf-after--p">But then we run into some problems: <code class="markup--code markup--p-code">")("</code> <code class="markup--code markup--p-code">"(()))("</code> return <code class="markup--code markup--p-code">true</code> even though they are poorly formatted. There is an equal number of open and closed parentheses, but they either start with a closing parenthesis or end with an opening parenthesis.</p>
<p name="d762" id="d762" class="graf graf--p graf-after--p">We could add an if statement to look at the first and last parentheses to check, but what about this case: <code class="markup--code markup--p-code">"())(()"</code>? The first and last parentheses are ok, there’s an equal number of opening and closing parentheses, but it’s still a bad string.</p>
<h4 name="cca8" id="cca8" class="graf graf--h4 graf-after--p">We Need A New Approach.</h4>
<p name="730f" id="730f" class="graf graf--p graf-after--h4">Let’s think again, how would we as humans look at this issue? A better way to do it would be, instead of counting open and closed parentheses, to keep track of how many parentheses remain open. So we go through the sentence, every time we get to an open parenthesis, we say “that’s one open,” “that’s two open,” etc. and every time we reach a closing parenthesis we count down: “that’s one open,” “no open,” etc. If we ever get below zero, we know we are in trouble, and if we reach the end with parentheses still open we know we are in trouble as well.</p>
<p name="3f81" id="3f81" class="graf graf--p graf-after--p">How would that look in JavaScript? Very similar to our last function:</p>
<pre name="c691" id="c691" class="graf graf--pre graf-after--p">function parenthesesChecker(text) {</pre>
<pre name="2587" id="2587" class="graf graf--pre graf-after--pre"> var open = 0</pre>
<pre name="b0eb" id="b0eb" class="graf graf--pre graf-after--pre"> for(i = 0; i &lt; text.length; i ++) {<br> if(text[i] === "(") {<br> open += 1<br> } else if(text[i] === ")") {<br> open -= 1<br> }<br> if(open &lt; 0)<br> return false<br> }</pre>
<pre name="98de" id="98de" class="graf graf--pre graf-after--pre"> return open === 0<br>}</pre>
<p name="303c" id="303c" class="graf graf--p graf-after--pre">The only difference is that instead of tracking two variables, <code class="markup--code markup--p-code">open</code> and <code class="markup--code markup--p-code">close</code>, we only track one variable named <code class="markup--code markup--p-code">open</code>. When we reach an open parenthesis, we increment our <code class="markup--code markup--p-code">open</code> variable, and when we reach a closing parenthesis, we decrement it. If the value of <code class="markup--code markup--p-code">open</code> ever goes below 0 we return <code class="markup--code markup--p-code">false</code> automatically, and if at the end it’s anything OTHER than 0 we return <code class="markup--code markup--p-code">false</code> as well.</p>
<p name="4c70" id="4c70" class="graf graf--p graf-after--p graf--trailing">This solution seems to work for all cases. If I missed anything, I’m sure you’ll point it out in the comments.</p>
</div></div></section>
</section>