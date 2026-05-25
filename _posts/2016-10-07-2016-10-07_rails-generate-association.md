---
title: "rails generate association"
date: 2016-10-07 05:03:34 +0000
permalink: /generating-belongs-to-associations-in-rails-be7b7fdea96c
header:
  teaser: /assets/images/posts/2016-10-07-2016-10-07_rails-generate-association-0.jpeg
tags:
  - 
categories:
  - 
---

<section data-field="body" class="e-content">
<section name="596d" class="section section--body section--first section--last"><div class="section-divider"><hr class="section-divider"></div>
<div class="section-content"><div class="section-inner sectionLayout--insetColumn">
<h3 name="9665" id="9665" class="graf graf--h3 graf--leading graf--title">rails generate association</h3>
<p name="b229" id="b229" class="graf graf--p graf-after--h3">The other day I stumbled upon a cool feature in Rails, entirely by accident. Being that I didn’t see it discussed much I figured I’d share it here.</p>
<p name="231b" id="231b" class="graf graf--p graf-after--p">For the sake of those less familiar with the concepts, I will start off with explaining what “associations” are in Rails. You may find this part boring; if you are already familiar with it, feel free to skip down to the section entitled “<strong class="markup--strong markup--p-strong">Get to the Point</strong>”.</p>
<h4 name="f2cf" id="f2cf" class="graf graf--h4 graf-after--p">belongs_to and has_many</h4>
<p name="393e" id="393e" class="graf graf--p graf-after--h4">To start with, we need to understand what associations are in Rails and how they work.</p>
<p name="306a" id="306a" class="graf graf--p graf-after--p">Say I build an app that tracks what snacks my cats like. My app needs to keep track of 2 concepts here, cats and snacks.</p>
<figure name="49ee" id="49ee" class="graf graf--figure graf-after--p"><img class="graf-image" data-image-id="1*3b7SyMMYmjFfnYTuA7E-AQ.jpeg" data-width="638" data-height="510" src="/assets/images/posts/2016-10-07-2016-10-07_rails-generate-association-0.jpeg"><figcaption class="imageCaption">Or cats that are snacks…</figcaption></figure><p name="0697" id="0697" class="graf graf--p graf-after--figure">So my app has a <code class="markup--code markup--p-code">Cat</code> Model and a <code class="markup--code markup--p-code">Snack</code> Model, but keeping track of just cats and snacks is not very useful to me, I want to know WHICH snacks WHICH cat likes. So in addition to keeping track of my cats and snacks, my app also has to keep track of the connections between specific cats and specific snacks.</p>
<p name="86c4" id="86c4" class="graf graf--p graf-after--p">In Rails we call these connections “Associations”, and these associations come in 2 flavors:</p>
<p name="5d43" id="5d43" class="graf graf--p graf-after--p">On the one hand, each snack has to be associated with a cat, I have to be able to ask the snack “which cat do you belong to?” and the snack has to be able to answer “I belong to cat X”. In rails, this is called a “belongs_to” association, where every Snack <code class="markup--code markup--p-code">belongs_to</code> a Cat.</p>
<figure name="18c8" id="18c8" class="graf graf--figure graf-after--p"><img class="graf-image" data-image-id="1*pI6MVPfZR5oFdYPoRBIfEA.jpeg" data-width="480" data-height="325" src="/assets/images/posts/2016-10-07-2016-10-07_rails-generate-association-1.jpeg"></figure><p name="92dc" id="92dc" class="graf graf--p graf-after--figure">Then we have the other side of the association, where each Cat owns all its snacks, so that if you ask a Cat “which snacks are yours?” it will be able to answer “Snack X,Y, and Z are mine”. This kind of association is called a “has_many” association, where each Cat <code class="markup--code markup--p-code">has_many</code> Snacks.</p>
<figure name="2166" id="2166" class="graf graf--figure graf-after--p"><img class="graf-image" data-image-id="1*pD412d_4gLtOzVI60j6IkQ.jpeg" data-width="800" data-height="576" src="/assets/images/posts/2016-10-07-2016-10-07_rails-generate-association-2.jpeg"></figure><p name="e835" id="e835" class="graf graf--p graf-after--figure">So to summarize, we have a 2-way association here where every Cat <code class="markup--code markup--p-code">has_many</code> Snacks and every snack <code class="markup--code markup--p-code">belongs_to</code> a Cat.</p>
<h4 name="babb" id="babb" class="graf graf--h4 graf-after--p">Foreign Keys</h4>
<p name="fe66" id="fe66" class="graf graf--p graf-after--h4">How does my app keep track of these associations? Simple. Every Cat in my app has a unique ID, all I have to do now is set up my Snack models in such a way that they have a property called <code class="markup--code markup--p-code">cat_id</code>, so when I ask the Snack “which Cat do you belong to?” all it has to do is look up its <code class="markup--code markup--p-code">cat_id</code> and say “I belong to Cat number 42”. Similarly, if I ask a Cat “which snacks do you like?” all the Cat has to do is look through the Snack list and find all of the Snacks that have its ID in their <code class="markup--code markup--p-code">cat_id</code> column.</p>
<h4 name="c1e2" id="c1e2" class="graf graf--h4 graf-after--p">Show me the code</h4>
<p name="985d" id="985d" class="graf graf--p graf-after--h4">Until now I’ve been speaking pretty high level. Let’s get down to the nitty-gritty code for a bit.</p>
<p name="61e4" id="61e4" class="graf graf--p graf-after--p">Here’s what our Cat model will look like:</p>
<pre name="9eae" id="9eae" class="graf graf--pre graf-after--p">class Cat &lt; ApplicationRecord<br> has_many :snacks<br>end</pre>
<p name="0d51" id="0d51" class="graf graf--p graf-after--pre">And here’s what our Snack model will look like:</p>
<pre name="1971" id="1971" class="graf graf--pre graf-after--p">class Snack &lt; ApplicationRecord<br> belongs_to :cat<br>end</pre>
<p name="6ebd" id="6ebd" class="graf graf--p graf-after--pre">Now in order for these Snacks and Cats to persist, we need to add them to a database with a <code class="markup--code markup--p-code">cats</code> table and a <code class="markup--code markup--p-code">snacks</code> table.</p>
<p name="c9db" id="c9db" class="graf graf--p graf-after--p">The way we do that in Rails is by setting up the following 2 ActiveRecord migrations:</p>
<pre name="16bc" id="16bc" class="graf graf--pre graf-after--p">class CreateCats &lt; ActiveRecord::Migration<br> def change</pre>
<pre name="725a" id="725a" class="graf graf--pre graf-after--pre"> create_table :cats do |t|<br> t.string :name<br> end</pre>
<pre name="18fb" id="18fb" class="graf graf--pre graf-after--pre"> end<br>end</pre>
<pre name="637e" id="637e" class="graf graf--pre graf-after--pre">class CreateSnacks &lt; ActiveRecord::Migration<br> def change</pre>
<pre name="5f96" id="5f96" class="graf graf--pre graf-after--pre"> create_table :snacks do |t|<br> t.string :name<br> t.integer :cat_id<br> end</pre>
<pre name="a6d4" id="a6d4" class="graf graf--pre graf-after--pre"> end<br>end</pre>
<p name="2756" id="2756" class="graf graf--p graf-after--pre">You’ll notice that both the <code class="markup--code markup--p-code">cats</code> table and the <code class="markup--code markup--p-code">snacks</code> table have a column for the <code class="markup--code markup--p-code">name</code> that accepts a string, and then the <code class="markup--code markup--p-code">snacks</code> table has another column <code class="markup--code markup--p-code">cat_id</code> that accepts an integer for the ID of the Cat the Snack <code class="markup--code markup--p-code">belongs_to</code>.</p>
<p name="f670" id="f670" class="graf graf--p graf-after--p">Of course, thanks to Rails Generators I didn’t have to type all of that out by hand, I was able to use Rails’ Model Generator to generate the Models and the Migrations using the commands <code class="markup--code markup--p-code">rails generate model Cat name:string</code> and <code class="markup--code markup--p-code">rails generate model Snack name:string cat_id:integer</code>. That generated the basic models and migrations, all I had to fill out was the <code class="markup--code markup--p-code">has_many</code> and <code class="markup--code markup--p-code">belongs_to</code> associations in the models.</p>
<h4 name="340f" id="340f" class="graf graf--h4 graf-after--p">Get to the Point</h4>
<p name="8957" id="8957" class="graf graf--p graf-after--h4">All of the above is pretty basic Rails, here’s the feature I discovered:</p>
<p name="8bc0" id="8bc0" class="graf graf--p graf-after--p">The other day I was pursuing a lesson on <a href="http://learn.co/with/achasveachas" data-href="http://learn.co/with/achasveachas" class="markup--anchor markup--p-anchor" rel="noopener" target="_blank">Learn.co,</a> the lesson was discussing a basic blog app where users can comment on posts. In this app, every comment <code class="markup--code markup--p-code">belongs_to</code> a User and a Post. The lab had snippets showing the code for the Models and Migrations, usually I would just skim over them and get to the actual lesson, this time however, something caught my eye:</p>
<pre name="aad8" id="aad8" class="graf graf--pre graf-after--p"><strong class="markup--strong markup--pre-strong">class</strong> <strong class="markup--strong markup--pre-strong">CreateComments</strong> <strong class="markup--strong markup--pre-strong">&lt;</strong> ActiveRecord<strong class="markup--strong markup--pre-strong">::</strong>Migration</pre>
<pre name="182e" id="182e" class="graf graf--pre graf-after--pre"><strong class="markup--strong markup--pre-strong"> def</strong> <strong class="markup--strong markup--pre-strong">change</strong></pre>
<pre name="2630" id="2630" class="graf graf--pre graf-after--pre"> create_table :comments <strong class="markup--strong markup--pre-strong">do</strong> <strong class="markup--strong markup--pre-strong">|</strong>t<strong class="markup--strong markup--pre-strong">|</strong></pre>
<pre name="ebff" id="ebff" class="graf graf--pre graf-after--pre"> t.<strong class="markup--strong markup--pre-strong">string</strong> :content</pre>
<pre name="c8bc" id="c8bc" class="graf graf--pre graf-after--pre"> t.<strong class="markup--strong markup--pre-strong">belongs_to</strong> :user</pre>
<pre name="7e8c" id="7e8c" class="graf graf--pre graf-after--pre"> t.<strong class="markup--strong markup--pre-strong">belongs_to</strong> :post</pre>
<pre name="774d" id="774d" class="graf graf--pre graf-after--pre"> t.<strong class="markup--strong markup--pre-strong">timestamps</strong> null: <strong class="markup--strong markup--pre-strong">false</strong></pre>
<pre name="a3de" id="a3de" class="graf graf--pre graf-after--pre"><strong class="markup--strong markup--pre-strong"> end</strong></pre>
<pre name="6989" id="6989" class="graf graf--pre graf-after--pre"><strong class="markup--strong markup--pre-strong"> end</strong></pre>
<pre name="f60b" id="f60b" class="graf graf--pre graf-after--pre"><strong class="markup--strong markup--pre-strong">end</strong></pre>
<p name="ecec" id="ecec" class="graf graf--p graf-after--pre">Wait a minute; I knew that <code class="markup--code markup--p-code">string</code> was a valid datatype for an attribute, and I knew <code class="markup--code markup--p-code">timestamps</code> was a valid datatype (it creates a date/time stamp when a new comment is created and another one every time it’s updated), but what’s a <code class="markup--code markup--p-code">belongs_to</code> datatype? Could it be that instead of having to put in a <code class="markup--code markup--p-code">user_id</code> I could just make a table column <code class="markup--code markup--p-code">t.belongs_to</code>?</p>
<p name="8a3b" id="8a3b" class="graf graf--p graf-after--p">I tried it out, I changed my Snacks database to the following:</p>
<pre name="d1da" id="d1da" class="graf graf--pre graf-after--p">class CreateSnacks &lt; ActiveRecord::Migration[5.0]<br> def change</pre>
<pre name="00a6" id="00a6" class="graf graf--pre graf-after--pre"> create_table :snacks do |t|<br> t.string :name<br> t.belongs_to :cat<br> end</pre>
<pre name="d983" id="d983" class="graf graf--pre graf-after--pre"> end<br>end</pre>
<p name="4cfe" id="4cfe" class="graf graf--p graf-after--pre">I ran the migration and lo and behold! My Snacks knew which Cat they belonged to! Apparently putting a <code class="markup--code markup--p-code">belongs_to</code> column into your migration with a model name as an argument adds a column <code class="markup--code markup--p-code">[model_name]_id</code>.</p>
<h4 name="6dc3" id="6dc3" class="graf graf--h4 graf-after--p">But will it Generate?</h4>
<p name="542b" id="542b" class="graf graf--p graf-after--h4">The next step was to see if I can use that with Rails’ Generators. So I ran <code class="markup--code markup--p-code">rails generate model Snack name:string cat:belongs_to</code> and sure enough when I checked the resulting migration this is what I found:</p>
<pre name="5f13" id="5f13" class="graf graf--pre graf-after--p">class CreateSnacks &lt; ActiveRecord::Migration[5.0]<br> def change<br> create_table :snacks do |t|<br> t.string :name<br> t.belongs_to :cat, foreign_key: true<br> t.timestamps<br> end<br> end<br>end</pre>
<p name="8e56" id="8e56" class="graf graf--p graf-after--pre">The <code class="markup--code markup--p-code">belongs_to</code> column was right there.</p>
<p name="ece7" id="ece7" class="graf graf--p graf-after--p">But that’s not all. When I took a look at the actual Model that was generated I found a surprise there too:</p>
<pre name="c035" id="c035" class="graf graf--pre graf-after--p">class Snack &lt; ApplicationRecord<br> belongs_to :cat<br>end</pre>
<p name="cc72" id="cc72" class="graf graf--p graf-after--pre">The <code class="markup--code markup--p-code">belongs_to</code> association was right there without me putting it in manually! When I generated a <code class="markup--code markup--p-code">belongs_to</code> attribute in my Snack migration Rails figured out that my Snack would belong to a Cat and put in that association there for me.</p>
<h4 name="628c" id="628c" class="graf graf--h4 graf-after--p">Reverse order?</h4>
<p name="5a66" id="5a66" class="graf graf--p graf-after--h4">Naturally, I was now curious to see if it would work in the reverse, could Rails generate a <code class="markup--code markup--p-code">has_many</code> association?</p>
<p name="2aac" id="2aac" class="graf graf--p graf-after--p">I ran <code class="markup--code markup--p-code">rails generate model Cat name:string snacks:has_many</code>. No luck.</p>
<p name="e6a9" id="e6a9" class="graf graf--p graf-after--p">the migration did have a <code class="markup--code markup--p-code">has_many</code> column:</p>
<pre name="845e" id="845e" class="graf graf--pre graf-after--p">class CreateCats &lt; ActiveRecord::Migration[5.0]<br> def change<br> create_table :cats do |t|<br> t.string :name<br> t.has_many :snacks<br> t.timestamps<br> end<br> end<br>end</pre>
<p name="45af" id="45af" class="graf graf--p graf-after--pre">but as far as I can tell that column is meaningless.</p>
<p name="e977" id="e977" class="graf graf--p graf-after--p">The model looked like:</p>
<pre name="c027" id="c027" class="graf graf--pre graf-after--p">class Cat &lt; ApplicationRecord<br>end</pre>
<p name="b99b" id="b99b" class="graf graf--p graf-after--pre">No automatic <code class="markup--code markup--p-code">has_many</code> association there either.</p>
<p name="5612" id="5612" class="graf graf--p graf-after--p">I was pretty pumped at having discovered all this. I started searching around sure I would find it being discussed, I didn’t find much about it out there, and definitely nothing on the fact that the association can be generated using standard Rails generators. I figured that would be strange, but I’m sure I’m not the only one who would be interested, so I hope this post can help someone else out there.</p>
<p name="ce35" id="ce35" class="graf graf--p graf-after--p graf--trailing">Happy Coding!</p>
</div></div></section>
</section>