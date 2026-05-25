---
title: "Add SMS Notifications to Your Rails App Using Twilio"
date: 2018-04-08 03:29:03 +0000
permalink: /2018-04-08_Add-SMS-Notifications-to-Your-Rails-App-Using-Twilio-202671ca8b85
header:
  teaser: /assets/images/posts/2018-04-08-2018-04-08_Add-SMS-Notifications-to-Your-Rails-App-Using-Twilio-0.jpg
tags:
  - 
categories:
  - 
---

<section data-field="body" class="e-content">
<section name="30ec" class="section section--body section--first section--last"><div class="section-divider"><hr class="section-divider"></div>
<div class="section-content">
<div class="section-inner sectionLayout--insetColumn">
<h3 name="6bc3" id="6bc3" class="graf graf--h3 graf--leading graf--title">Add SMS Notifications to Your Rails App Using Twilio</h3>
<figure name="a91f" id="a91f" class="graf graf--figure graf-after--h3"><img class="graf-image" data-image-id="0*uPILUKzVW2fObWkb.jpg" data-width="1000" data-height="688" src="/assets/images/posts/2018-04-08-2018-04-08_Add-SMS-Notifications-to-Your-Rails-App-Using-Twilio-0.jpg"></figure><p name="59f7" id="59f7" class="graf graf--p graf-after--figure">Anyone living in NYC with a car knows the pain that is Alternate Side Parking rules. There’s the need to always to be conscious of which side of the street your car is parked on, to run out at the most inopportune times to move it to the other side of the street, and occasionally the opportunity to be blocked in by someone double-parking. All of these, and more, are part of what New York drivers have to put up with on a weekly cycle.</p>
<figure name="6862" id="6862" class="graf graf--figure graf-after--p"><img class="graf-image" data-image-id="0*eiWfOVn6AlFhW_J1.png" data-width="1280" data-height="853" src="/assets/images/posts/2018-04-08-2018-04-08_Add-SMS-Notifications-to-Your-Rails-App-Using-Twilio-1.png"><figcaption class="imageCaption">You mean I have to move this car?</figcaption></figure><p name="cb64" id="cb64" class="graf graf--p graf-after--figure">To help me deal with it, I created <a href="https://twitter.com/AlterSideBot" data-href="https://twitter.com/AlterSideBot" class="markup--anchor markup--p-anchor" rel="noopener" target="_blank">@AlterSideBot</a>, a Twitter Bot that retweets whenever <a href="http://www1.nyc.gov/nyc-resources/service/1029/alternate-side-parking-or-street-cleaning" data-href="http://www1.nyc.gov/nyc-resources/service/1029/alternate-side-parking-or-street-cleaning" class="markup--anchor markup--p-anchor" rel="noopener" target="_blank">Alternate Side Parking rules</a> are suspended so I know I don’t have to worry on those days.</p>
<p name="b400" id="b400" class="graf graf--p graf-after--p">The idea hit on and followers kept coming in… but it had its limitations. First of all, most people aren’t glued to their Twitter feeds, and one tweet can easily get lost in the noise. Not to mention that many people don’t even use Twitter (or use it rarely enough) so my bot wouldn’t be helpful to them at all.</p>
<p name="c59c" id="c59c" class="graf graf--p graf-after--p">For this reason, I decided to add SMS functionality to my Twitter bot, so people could subscribe to receive SMS notifications to their phones.</p>
<p name="0fa5" id="0fa5" class="graf graf--p graf-after--p">The app was a fantastic success; within a few days I had over 100 subscribers. I had a lot of fun making it, so I figured I’d write up the process.</p>
<p name="73c8" id="73c8" class="graf graf--p graf-after--p">For the sake of this tutorial I won’t go into the making of the Twitter bot (that’s a <a href="https://blog.yechiel.me/creating-my-first-twitter-bot-b5e0da5c8cbb?gi=da4d1ec61053" data-href="https://blog.yechiel.me/creating-my-first-twitter-bot-b5e0da5c8cbb?gi=da4d1ec61053" class="markup--anchor markup--p-anchor" rel="noopener" target="_blank">whole blog post in itself</a>), instead, we will create a much simpler app where people can subscribe to receive cat facts.</p>
<h3 name="f84d" id="f84d" class="graf graf--h3 graf-after--p">What you’ll need</h3>
<ul class="postList">
<li name="b70f" id="b70f" class="graf graf--li graf-after--h3">A computer running MacOS or Linux (if you’re using Windows 10 you can follow <a href="https://gorails.com/setup/windows/10" data-href="https://gorails.com/setup/windows/10" class="markup--anchor markup--li-anchor" rel="noopener" target="_blank">this guide</a> to install Rails)</li>
<li name="8a24" id="8a24" class="graf graf--li graf-after--li">
<a href="http://rubyonrails.org/" data-href="http://rubyonrails.org/" class="markup--anchor markup--li-anchor" rel="noopener" target="_blank">Rails version 5</a> or higher</li>
<li name="f4a9" id="f4a9" class="graf graf--li graf-after--li">A Twilio account (<a href="https://www.twilio.com/try-twilio" data-href="https://www.twilio.com/try-twilio" class="markup--anchor markup--li-anchor" rel="noopener" target="_blank">you can sign up for a free trial here</a>) with a phone number that can send/receive SMS’s</li>
<li name="2b68" id="2b68" class="graf graf--li graf-after--li">A telephone that can send/receive SMS messages so you can test your app out</li>
</ul>
<h3 name="0b0b" id="0b0b" class="graf graf--h3 graf-after--li">Building the Rails Cat Facts app</h3>
<h4 name="01ca" id="01ca" class="graf graf--h4 graf-after--h3">Getting started</h4>
<p name="a42b" id="a42b" class="graf graf--p graf-after--h4">Let’s start by creating our Rails app. In your terminal run <code class="markup--code markup--p-code">rails new cat_facts</code>. This will generate a template for a basic Rails app called Cat Facts. When your terminal finishes doing what it’s doing type <code class="markup--code markup--p-code">cd cat_facts</code> to go into the root directory of your app.</p>
<p name="e690" id="e690" class="graf graf--p graf-after--p">Open the newly created cat_facts directory in your favorite editor, and let’s get going.</p>
<h4 name="8ea0" id="8ea0" class="graf graf--h4 graf-after--p">Give me the facts</h4>
<p name="ab39" id="ab39" class="graf graf--p graf-after--h4">We will start by creating our <code class="markup--code markup--p-code">CatFact</code> model, the nerve engine of our app.</p>
<p name="6d97" id="6d97" class="graf graf--p graf-after--p">In your terminal run <code class="markup--code markup--p-code">rails generate model cat_fact fact:string</code>. This should generate a <code class="markup--code markup--p-code">CatFact</code> model that has a <code class="markup--code markup--p-code">fact</code> attribute where we will store our facts, as well as a migration that should look like this:</p>
<pre name="5742" id="5742" class="graf graf--pre graf-after--p">class CreateCatFacts &lt; ActiveRecord::Migration[5.1]<br> def change<br> create_table :cat_facts do |t|<br> t.string :fact<br> t.timestamps <br> end<br> end<br>end</pre>
<p name="8963" id="8963" class="graf graf--p graf-after--pre">Double check that everything looks the way it should and run <code class="markup--code markup--p-code">rails db:migrate</code> to create the database table.</p>
<p name="e1d2" id="e1d2" class="graf graf--p graf-after--p">Now let’s generate the controller by running <code class="markup--code markup--p-code">rails generate controller cat_facts index create</code> this will generate a <code class="markup--code markup--p-code">CatFactsController</code> with an <code class="markup--code markup--p-code">index</code> and a <code class="markup--code markup--p-code">create</code> action.</p>
<p name="a9c1" id="a9c1" class="graf graf--p graf-after--p">The controller will have also created routes for our app at <code class="markup--code markup--p-code">GET cat_facts/index and GET cat_facts/create</code>. That’s more complex than we need, let’s go to <code class="markup--code markup--p-code">config/routes.rb</code> and replace the contents of that file with the following:</p>
<pre name="f276" id="f276" class="graf graf--pre graf-after--p">Rails.application.routes.draw do</pre>
<pre name="df4b" id="df4b" class="graf graf--pre graf-after--pre"> resources :cat_facts, only: [:create, :index]</pre>
<pre name="a2fd" id="a2fd" class="graf graf--pre graf-after--pre">end</pre>
<p name="20aa" id="20aa" class="graf graf--p graf-after--pre">That will give us a route at <code class="markup--code markup--p-code">GET /cat_facts</code> where we will display all the facts and a <code class="markup--code markup--p-code">POST /cat_facts</code> route we can use to create new Cat Facts.</p>
<h4 name="b21b" id="b21b" class="graf graf--h4 graf-after--p">An App with a View</h4>
<p name="6255" id="6255" class="graf graf--p graf-after--h4">Let us now build out our view. Put the following in <code class="markup--code markup--p-code">app/views/cat_facts/index.html.erb</code>:</p>
<pre name="b144" id="b144" class="graf graf--pre graf-after--p">&lt;h1&gt;Cat Facts&lt;/h1&gt;</pre>
<pre name="87fe" id="87fe" class="graf graf--pre graf-after--pre">&lt;p&gt;Add a new cat fact:&lt;/p&gt;</pre>
<pre name="626c" id="626c" class="graf graf--pre graf-after--pre">&lt;%= form_for @cat_fact do |f| %&gt;</pre>
<pre name="aff2" id="aff2" class="graf graf--pre graf-after--pre"> &lt;%= f.label :fact %&gt;&lt;br&gt;</pre>
<pre name="94c9" id="94c9" class="graf graf--pre graf-after--pre"> &lt;%= f.text_area :fact %&gt;&lt;br&gt;</pre>
<pre name="ba47" id="ba47" class="graf graf--pre graf-after--pre"> &lt;%= f.submit %&gt;</pre>
<pre name="50a9" id="50a9" class="graf graf--pre graf-after--pre">&lt;% end %&gt;</pre>
<p name="325b" id="325b" class="graf graf--p graf-after--pre">This will give us a form to create new Cat Facts.</p>
<p name="e9d8" id="e9d8" class="graf graf--p graf-after--p">Under that put the following:</p>
<pre name="d13d" id="d13d" class="graf graf--pre graf-after--p">&lt;h3&gt;Previous Facts:&lt;/h3&gt;</pre>
<pre name="ce70" id="ce70" class="graf graf--pre graf-after--pre">&lt;ul&gt;</pre>
<pre name="fbc1" id="fbc1" class="graf graf--pre graf-after--pre"> &lt;% @cat_facts.each do |cat_fact| %&gt;</pre>
<pre name="7012" id="7012" class="graf graf--pre graf-after--pre"> &lt;li&gt;&lt;%= cat_fact.fact %&gt;&lt;/li&gt;</pre>
<pre name="9d6c" id="9d6c" class="graf graf--pre graf-after--pre"> &lt;% end %&gt;</pre>
<pre name="b82d" id="b82d" class="graf graf--pre graf-after--pre">&lt;/ul&gt;</pre>
<p name="3f27" id="3f27" class="graf graf--p graf-after--pre">This will let us see a list of all the facts we created.</p>
<p name="4b66" id="4b66" class="graf graf--p graf-after--p">Let us now build out our controller. In <code class="markup--code markup--p-code">app/controllers/cat_facts_controller.rb</code> edit the index method to look like the following:</p>
<pre name="b124" id="b124" class="graf graf--pre graf-after--p">def index</pre>
<pre name="c869" id="c869" class="graf graf--pre graf-after--pre"> @cat_fact = CatFact.new</pre>
<pre name="3505" id="3505" class="graf graf--pre graf-after--pre"> @cat_facts = CatFact.all</pre>
<pre name="97a1" id="97a1" class="graf graf--pre graf-after--pre">end</pre>
<p name="7ee3" id="7ee3" class="graf graf--p graf-after--pre">And the <code class="markup--code markup--p-code">create</code> method as follows:</p>
<pre name="4582" id="4582" class="graf graf--pre graf-after--p">def create</pre>
<pre name="9c51" id="9c51" class="graf graf--pre graf-after--pre"> @cat_fact = CatFact.new</pre>
<pre name="2ef6" id="2ef6" class="graf graf--pre graf-after--pre"> @cat_fact.fact = params[:cat_fact][:fact]</pre>
<pre name="ce47" id="ce47" class="graf graf--pre graf-after--pre"> @cat_fact.save</pre>
<pre name="495e" id="495e" class="graf graf--pre graf-after--pre"> redirect_to cat_facts_path</pre>
<pre name="d7c1" id="d7c1" class="graf graf--pre graf-after--pre">end</pre>
<p name="8447" id="8447" class="graf graf--p graf-after--pre">We can now test this out. Run <code class="markup--code markup--p-code">rails server</code> in your terminal. Open up a browser and go to <a href="http://localhost:3000/cat_facts" data-href="http://localhost:3000/cat_facts" class="markup--anchor markup--p-anchor" target="_blank">http://localhost:3000/cat_facts</a>, you should see a form for new cat facts. If you put in a fact and hit submit you should see it appear below the form.</p>
<figure name="e466" id="e466" class="graf graf--figure graf-after--p"><img class="graf-image" data-image-id="0*fmSCHcnB9l4tDmvH.png" data-width="882" data-height="542" src="/assets/images/posts/2018-04-08-2018-04-08_Add-SMS-Notifications-to-Your-Rails-App-Using-Twilio-2.png"></figure><h3 name="63c8" id="63c8" class="graf graf--h3 graf-after--figure">Adding SMS notifications</h3>
<p name="1174" id="1174" class="graf graf--p graf-after--h3">Now that we have the base of our app working we can connect it to our Twilio account and let people subscribe to receive notifications.</p>
<h4 name="182a" id="182a" class="graf graf--h4 graf-after--p">Configure our app</h4>
<p name="48e0" id="48e0" class="graf graf--p graf-after--h4">First let’s add the <code class="markup--code markup--p-code">twilio-ruby</code> gem so our app can talk to Twilio. In your Gemfile add the following line: <code class="markup--code markup--p-code">gem 'twilio-ruby'</code> and then run <code class="markup--code markup--p-code">bundle install</code> in your terminal.</p>
<p name="5d02" id="5d02" class="graf graf--p graf-after--p">Next, we will have to give our app your Twilio credentials. Log in to your Twilio account and go to the <a href="https://www.twilio.com/console" data-href="https://www.twilio.com/console" class="markup--anchor markup--p-anchor" rel="noopener" target="_blank">console</a>. At the top left, you will see your Account SID and Auth Token, take note of them for the next step.</p>
<figure name="3fb8" id="3fb8" class="graf graf--figure graf-after--p"><img class="graf-image" data-image-id="0*EkdcU7QBj4YLQHis.png" data-width="775" data-height="419" src="/assets/images/posts/2018-04-08-2018-04-08_Add-SMS-Notifications-to-Your-Rails-App-Using-Twilio-3.png"></figure><p name="e762" id="e762" class="graf graf--p graf-after--figure">In your app, create a file in <code class="markup--code markup--p-code">config/initializers</code> called <code class="markup--code markup--p-code">twilio.rb</code> and paste the following code:</p>
<pre name="cf03" id="cf03" class="graf graf--pre graf-after--p">Twilio.configure do |config|</pre>
<pre name="6923" id="6923" class="graf graf--pre graf-after--pre"> config.account_sid = "ACCOUNT_SID"</pre>
<pre name="34f8" id="34f8" class="graf graf--pre graf-after--pre"> config.auth_token = "AUTH_TOKEN"</pre>
<pre name="4e96" id="4e96" class="graf graf--pre graf-after--pre">end</pre>
<p name="9249" id="9249" class="graf graf--p graf-after--pre">Make sure you replace <code class="markup--code markup--p-code">ACCOUNT_SID</code> and <code class="markup--code markup--p-code">AUTH_TOKEN</code> with the Account SID and Auth token you saved in the last step (if you are planning on uploading the code to GitHub or the like do not commit your token and SID, instead consider using environment variables).</p>
<p name="2430" id="2430" class="graf graf--p graf-after--p">Next, let’s set up a route for Twilio to interact with our app. In your terminal type: <code class="markup--code markup--p-code">rails generate controller twilio sms</code>. This will give our app a route at <code class="markup--code markup--p-code">get '/twilio/sms'</code> along with a corresponding <code class="markup--code markup--p-code">TwilioController</code> with an <code class="markup--code markup--p-code">sms</code> action.</p>
<p name="e0fe" id="e0fe" class="graf graf--p graf-after--p">In config/routes.rb let’s change the <code class="markup--code markup--p-code">get '/twilio/sms'</code> route to <code class="markup--code markup--p-code">post '/twilio/sms'</code>.</p>
<h4 name="a11d" id="a11d" class="graf graf--h4 graf-after--p">Configure Twilio</h4>
<p name="4f9e" id="4f9e" class="graf graf--p graf-after--h4">Now we need to tell Twilio where to find your app, but in order to do that we need to expose our app to the internet. We will do that using ngrok.</p>
<p name="8502" id="8502" class="graf graf--p graf-after--p">To check if you already have ngrok installed on your computer type <code class="markup--code markup--p-code">ngrok help</code> in your terminal. If a list of commands shows up in the terminal you are good to go, if you got an error <code class="markup--code markup--p-code">ngrok: command not found</code> you will need to download and install ngrok <a href="https://ngrok.com/download" data-href="https://ngrok.com/download" class="markup--anchor markup--p-anchor" rel="noopener" target="_blank">here</a>.</p>
<p name="e239" id="e239" class="graf graf--p graf-after--p">Once you have ngrok installed open up another terminal and type <code class="markup--code markup--p-code">ngrok http 3000</code>. You should see something similar to this in your terminal:</p>
<figure name="7bab" id="7bab" class="graf graf--figure graf-after--p"><img class="graf-image" data-image-id="0*Lcg6uqsGS5liCQJj.png" data-width="644" data-height="286" src="/assets/images/posts/2018-04-08-2018-04-08_Add-SMS-Notifications-to-Your-Rails-App-Using-Twilio-4.png"></figure><p name="1094" id="1094" class="graf graf--p graf-after--figure">This means that ngrok opened up a window to port 3000 on your localhost and exposed it to the internet at the URL it shows by “Forwarding” (which will be different than the one in the screenshot above).</p>
<p name="ac74" id="ac74" class="graf graf--p graf-after--p">Now go back to your Twilio Dashboard and click on “Manage Numbers” in the Phone Numbers section, and then click on the phone number you will be connecting to our app.</p>
<p name="5714" id="5714" class="graf graf--p graf-after--p">Under the Messaging section, by “A Message Comes In” choose “Webhook”. In the field next to Webhook put in the URL ngrok gave you followed by <code class="markup--code markup--p-code">/twilio/sms</code> (so it should look like <code class="markup--code markup--p-code">https://ngrokurl.ngrok.io/twilio/sms</code> replacing <code class="markup--code markup--p-code">ngrokurl</code> with the URL in your terminal) and choose “HTTP POST” then hit “Save”.</p>
</div>
<div class="section-inner sectionLayout--outsetColumn"><figure name="365f" id="365f" class="graf graf--figure graf--layoutOutsetCenter graf-after--p"><img class="graf-image" data-image-id="0*hvqDqYZZrXbtWDsC.png" data-width="1397" data-height="279" src="/assets/images/posts/2018-04-08-2018-04-08_Add-SMS-Notifications-to-Your-Rails-App-Using-Twilio-5.png"></figure></div>
<div class="section-inner sectionLayout--insetColumn">
<p name="dabb" id="dabb" class="graf graf--p graf-after--figure">Now Twilio will forward any incoming messages to the ngrok route we specified, which will in turn forward it to our localhost at port 3000. Let’s configure our app to respond.</p>
<h4 name="38d2" id="38d2" class="graf graf--h4 graf-after--p">TwiML-dee TwiML-dum</h4>
<p name="dbc9" id="dbc9" class="graf graf--p graf-after--h4">The Twilio API communicates using TwiML (which <a href="https://www.twilio.com/docs/glossary/what-is-twilio-markup-language-twiml" data-href="https://www.twilio.com/docs/glossary/what-is-twilio-markup-language-twiml" class="markup--anchor markup--p-anchor" rel="noopener" target="_blank">stands for Twilio Markup Language</a>. A markup scheme similar to XML) using verbs like <a href="https://www.twilio.com/docs/sms/twiml/message" data-href="https://www.twilio.com/docs/sms/twiml/message" class="markup--anchor markup--p-anchor" rel="noopener" target="_blank">&lt;Message&gt;</a> to send text messages and <a href="https://www.twilio.com/docs/voice/twiml/say" data-href="https://www.twilio.com/docs/voice/twiml/say" class="markup--anchor markup--p-anchor" rel="noopener" target="_blank">&lt;Say&gt;</a> to send voice. Thankfully, the Twilio gem we installed will handle creating the TwiML for us using the <code class="markup--code markup--p-code">Twilio::TwiML</code> class. Let’s use it to create our app’s responses.</p>
<p name="0e77" id="0e77" class="graf graf--p graf-after--p">In <code class="markup--code markup--p-code">app/controllers/twilio_controller.rb</code> let’s put the following code in the <code class="markup--code markup--p-code">TwilioController</code>:</p>
<pre name="a45e" id="a45e" class="graf graf--pre graf-after--p">class TwilioController &lt; ApplicationController</pre>
<pre name="7049" id="7049" class="graf graf--pre graf-after--pre"> skip_before_action :verify_authenticity_token</pre>
<pre name="3d91" id="3d91" class="graf graf--pre graf-after--pre"> <br> def sms</pre>
<pre name="ba1b" id="ba1b" class="graf graf--pre graf-after--pre"> body = helpers.parse_sms(params)<br><br></pre>
<pre name="df4a" id="df4a" class="graf graf--pre graf-after--pre"> response = Twilio::TwiML::MessagingResponse.new do |r|</pre>
<pre name="cec2" id="cec2" class="graf graf--pre graf-after--pre"> r.message body: body</pre>
<pre name="3b30" id="3b30" class="graf graf--pre graf-after--pre"> end<br><br></pre>
<pre name="2f86" id="2f86" class="graf graf--pre graf-after--pre"> render xml: response.to_s</pre>
<pre name="692c" id="692c" class="graf graf--pre graf-after--pre"> end</pre>
<pre name="c820" id="c820" class="graf graf--pre graf-after--pre">end</pre>
<p name="7ce2" id="7ce2" class="graf graf--p graf-after--pre">What that does is set a variable <code class="markup--code markup--p-code">response</code> to a TwiML Response object that contains the text “Hello World” in the body. We then render that response object as XML. The result is an XML response that looks like this:</p>
<pre name="bf70" id="bf70" class="graf graf--pre graf-after--p">&lt;?xml version=\”1.0\” encoding=\”UTF-8\”?&gt;</pre>
<pre name="a2b4" id="a2b4" class="graf graf--pre graf-after--pre">&lt;Response&gt;</pre>
<pre name="4b3d" id="4b3d" class="graf graf--pre graf-after--pre"> &lt;Message&gt;Hello World&lt;/Message&gt;</pre>
<pre name="2b74" id="2b74" class="graf graf--pre graf-after--pre">&lt;/Response&gt;</pre>
<figure name="8ae1" id="8ae1" class="graf graf--figure graf-after--pre"><img class="graf-image" data-image-id="0*x9uEQxUZkbSIv7zs.png" data-width="1259" data-height="1280" src="/assets/images/posts/2018-04-08-2018-04-08_Add-SMS-Notifications-to-Your-Rails-App-Using-Twilio-6.png"><figcaption class="imageCaption">Pretty sure that goes there…</figcaption></figure><p name="acba" id="acba" class="graf graf--p graf-after--figure">Let’s test it out; type <code class="markup--code markup--p-code">rails server</code> in your console (if you still have your rails server running from earlier shut it down and restart it so our latest changes take effect), then send an SMS to your Twilio number. You should receive a text message in response with the text “Hello World”. Neat no?</p>
<p name="cbe7" id="cbe7" class="graf graf--p graf-after--p">(Confession: seeing my phone light up for the first time with a text message I had sent using code was one of those moments that reminded me why I fell in love with coding in the first place!)</p>
<h3 name="b3c4" id="b3c4" class="graf graf--h3 graf-after--p">It’s all about the cats!</h3>
<p name="aaa4" id="aaa4" class="graf graf--p graf-after--h3">Of course, as cool as that was, we are building a <em class="markup--em markup--p-em">Cat Facts</em> app, not a <em class="markup--em markup--p-em">Hello World</em> app, so let’s change our TwiML object to return content that’s a bit more dynamic.</p>
<p name="577d" id="577d" class="graf graf--p graf-after--p">Let’s change our response object to look as follows:</p>
<pre name="d9aa" id="d9aa" class="graf graf--pre graf-after--p">response = Twilio::TwiML::MessagingResponse.new do |r|</pre>
<pre name="3a7f" id="3a7f" class="graf graf--pre graf-after--pre"> r.message body: CatFact.last.fact</pre>
<pre name="aa2b" id="aa2b" class="graf graf--pre graf-after--pre">end</pre>
<p name="fc5e" id="fc5e" class="graf graf--p graf-after--pre">If you send an SMS to your Twilio number now, you should receive a response with the latest Cat Fact you added to your app.</p>
<p name="9f96" id="9f96" class="graf graf--p graf-after--p">We now have an app that users can text whenever they want and receive the latest cat facts in response. How cool is that?!</p>
<h3 name="9bf4" id="9bf4" class="graf graf--h3 graf-after--p">Subscribe!</h3>
<p name="3a12" id="3a12" class="graf graf--p graf-after--h3">But our users want more; they don’t want to have to keep texting us in the hope that we added a new fact, they want to be able to subscribe to receive notifications as soon as new cat facts come out!</p>
<p name="3f63" id="3f63" class="graf graf--p graf-after--p">To do that we will need to add some logic to our app so it can parse incoming text messages and respond accordingly.</p>
<p name="b121" id="b121" class="graf graf--p graf-after--p">We could put all that logic in our <code class="markup--code markup--p-code">sms</code> controller action, but that would make for a pretty fat controller. Instead, we will put it in a helper method.</p>
<p name="4b00" id="4b00" class="graf graf--p graf-after--p">But before we get there, we need to have a way of storing our subscribers in our database.</p>
<p name="ff5d" id="ff5d" class="graf graf--p graf-after--p">In your terminal type: <code class="markup--code markup--p-code">rails generate model subscriber phone_number</code>. That will give us a <code class="markup--code markup--p-code">Subscriber</code> model with a <code class="markup--code markup--p-code">phone_number</code> attribute. Run <code class="markup--code markup--p-code">rails db:migrate</code> in your terminal to add that table to our database.</p>
<p name="c44c" id="c44c" class="graf graf--p graf-after--p">Now we can build a helper method that will help us parse users’ text messages so that they can subscribe to our app.</p>
<p name="1f1a" id="1f1a" class="graf graf--p graf-after--p">Let’s think of what we want our users to be able to do.</p>
<p name="3917" id="3917" class="graf graf--p graf-after--p">Users should be able to:</p>
<ul class="postList">
<li name="10d1" id="10d1" class="graf graf--li graf-after--p">Send a message <strong class="markup--strong markup--li-strong">SUBSCRIBE</strong> to subscribe to our app</li>
<li name="b527" id="b527" class="graf graf--li graf-after--li">Send <strong class="markup--strong markup--li-strong">FACT</strong> if they want to get the latest cat fact</li>
<li name="71cd" id="71cd" class="graf graf--li graf-after--li">Send <strong class="markup--strong markup--li-strong">UNSUBSCRIBE</strong> if they want to stop receiving notifications</li>
</ul>
<p name="cff7" id="cff7" class="graf graf--p graf-after--li">(who would want to stop getting cat facts? I know! That said, please don’t make a subscription-based app where users can’t unsubscribe easily)</p>
<h4 name="ca61" id="ca61" class="graf graf--h4 graf-after--p">Parsing messages</h4>
<p name="ca24" id="ca24" class="graf graf--p graf-after--h4">To do that we will build a method that can analyze the incoming text message, see what it says, and return an appropriate response.</p>
<p name="73f8" id="73f8" class="graf graf--p graf-after--p">Go to <code class="markup--code markup--p-code">app/helpers/twilio_helper.rb</code> and put the following method in the <code class="markup--code markup--p-code">TwilioHelper</code> Module:</p>
<pre name="75b7" id="75b7" class="graf graf--pre graf-after--p">def parse_sms(sms)</pre>
<pre name="3529" id="3529" class="graf graf--pre graf-after--pre"> body = sms[:Body]&amp;.strip&amp;.upcase</pre>
<pre name="b311" id="b311" class="graf graf--pre graf-after--pre"> from = sms[:From]</pre>
<pre name="3e0f" id="3e0f" class="graf graf--pre graf-after--pre"> case body</pre>
<pre name="1f79" id="1f79" class="graf graf--pre graf-after--pre"> when "SUBSCRIBE"</pre>
<pre name="5467" id="5467" class="graf graf--pre graf-after--pre"> subscriber = Subscriber.create(phone_number: from)</pre>
<pre name="53ca" id="53ca" class="graf graf--pre graf-after--pre"> return "The number #{from} has been subscribed to receive cat facts. Text UNSUBSCRIBE at any time to unsubscribe."</pre>
<pre name="ea8a" id="ea8a" class="graf graf--pre graf-after--pre"> when "UNSUBSCRIBE"</pre>
<pre name="5d67" id="5d67" class="graf graf--pre graf-after--pre"> subscriber = Subscriber.find_by(phone_number: from)</pre>
<pre name="a462" id="a462" class="graf graf--pre graf-after--pre"> if subscriber</pre>
<pre name="ff90" id="ff90" class="graf graf--pre graf-after--pre"> subscriber.destroy</pre>
<pre name="b7b6" id="b7b6" class="graf graf--pre graf-after--pre"> return "The number #{from} has been unsubscribed. Text SUBSCRIBE at any time to resubscribe."</pre>
<pre name="ddbc" id="ddbc" class="graf graf--pre graf-after--pre"> else</pre>
<pre name="0d17" id="0d17" class="graf graf--pre graf-after--pre"> return "Sorry, I did not find a subscriber with the number #{from}."</pre>
<pre name="af3f" id="af3f" class="graf graf--pre graf-after--pre"> end</pre>
<pre name="7f99" id="7f99" class="graf graf--pre graf-after--pre"> when "FACT"</pre>
<pre name="66a3" id="66a3" class="graf graf--pre graf-after--pre"> return CatFact.last.fact</pre>
<pre name="4ecd" id="4ecd" class="graf graf--pre graf-after--pre"> else</pre>
<pre name="7997" id="7997" class="graf graf--pre graf-after--pre"> return "Sorry I didn’t get that. the available commands are SUBSCRIBE, UNSUBSCRIBE, and FACT."</pre>
<pre name="60a8" id="60a8" class="graf graf--pre graf-after--pre"> end</pre>
<pre name="920c" id="920c" class="graf graf--pre graf-after--pre">end</pre>
<p name="04bf" id="04bf" class="graf graf--p graf-after--pre">What that does is define a <code class="markup--code markup--p-code">parse_sms</code> method that takes in an SMS as an argument (really just the params hash twilio sent along with the <code class="markup--code markup--p-code">GET</code> request). The method then passes the body of the SMS to a switch statement that checks it. If the body of the SMS says <strong class="markup--strong markup--p-strong">SUBSCRIBE</strong> it will subscribe the incoming number, if it says <strong class="markup--strong markup--p-strong">UNSUBSCRIBE</strong> it will unsubscribe that number, and if it says <strong class="markup--strong markup--p-strong">FACT</strong> it will return the latest cat fact.</p>
<p name="0922" id="0922" class="graf graf--p graf-after--p">In each case, the method returns a helpful message. If the incoming text didn’t match any of those, a helpful message is returned with the available commands.</p>
<p name="4b03" id="4b03" class="graf graf--p graf-after--p">Now let’s update our sms controller as follows:</p>
<pre name="105b" id="105b" class="graf graf--pre graf-after--p">def sms</pre>
<pre name="7fad" id="7fad" class="graf graf--pre graf-after--pre"> body = helpers.parse_sms(params)</pre>
<pre name="8450" id="8450" class="graf graf--pre graf-after--pre"> response = Twilio::TwiML::MessagingResponse.new do |r|</pre>
<pre name="b115" id="b115" class="graf graf--pre graf-after--pre"> r.message body: body</pre>
<pre name="a0da" id="a0da" class="graf graf--pre graf-after--pre"> end</pre>
<pre name="6729" id="6729" class="graf graf--pre graf-after--pre"> render xml: response.to_s</pre>
<pre name="9a09" id="9a09" class="graf graf--pre graf-after--pre">end</pre>
<p name="5039" id="5039" class="graf graf--p graf-after--pre">What we’re doing is we’re taking the incoming params and passing them to the <code class="markup--code markup--p-code">parse_sms</code> method we defined earlier.</p>
<p name="956a" id="956a" class="graf graf--p graf-after--p">We then take the string we got back from <code class="markup--code markup--p-code">parse_sms</code> and create a TwiML response object and using the response as the body. We then convert the TwiML object to XML and send it back to Twilio.</p>
<h3 name="0821" id="0821" class="graf graf--h3 graf-after--p">But does it work?</h3>
<p name="b273" id="b273" class="graf graf--p graf-after--h3">Let’s test it out. Fire up your <code class="markup--code markup--p-code">rails server</code> again if you shut it down and text <strong class="markup--strong markup--p-strong">SUBSCRIBE</strong> to your Twilio number. You should soon receive a response that your number has been subscribed. If you now go to your <code class="markup--code markup--p-code">rails console</code> and run <code class="markup--code markup--p-code">Subscriber.last.phone_number</code> your phone number should come up.</p>
<h3 name="2ee2" id="2ee2" class="graf graf--h3 graf-after--p">Almost done!</h3>
<p name="965d" id="965d" class="graf graf--p graf-after--h3">The only thing we have left now is to set our app up to send notifications to our subscribers whenever we add a new cat fact.</p>
<p name="73e7" id="73e7" class="graf graf--p graf-after--p">Let’s go to <code class="markup--code markup--p-code">app/models/cat_fact.rb</code> and in our <code class="markup--code markup--p-code">CatFact</code> class let’s add the following method:</p>
<pre name="366c" id="366c" class="graf graf--pre graf-after--p">def notify_subscribers</pre>
<pre name="b55d" id="b55d" class="graf graf--pre graf-after--pre"> client = Twilio::REST::Client.new</pre>
<pre name="f34d" id="f34d" class="graf graf--pre graf-after--pre"> Subscriber.find_each do |subscriber|</pre>
<pre name="39cb" id="39cb" class="graf graf--pre graf-after--pre"> client.messages.create(</pre>
<pre name="17ab" id="17ab" class="graf graf--pre graf-after--pre"> from: "YOUR_TWILIO_PHONE_NUMBER",</pre>
<pre name="1ab5" id="1ab5" class="graf graf--pre graf-after--pre"> to: subscriber.phone_number,</pre>
<pre name="7a3d" id="7a3d" class="graf graf--pre graf-after--pre"> body: self.fact</pre>
<pre name="19c8" id="19c8" class="graf graf--pre graf-after--pre"> )</pre>
<pre name="6bb7" id="6bb7" class="graf graf--pre graf-after--pre"> end</pre>
<pre name="68f6" id="68f6" class="graf graf--pre graf-after--pre">end</pre>
<p name="19a4" id="19a4" class="graf graf--p graf-after--pre">That method iterates through all of our subscribers and uses the Twilio REST API to send each of them a text message with the given cat fact as the body (don’t forget to replace <code class="markup--code markup--p-code">YOUR_TWILIO_PHONE_NUMBER</code> with your actual Twilio number using the format “+19876543210”).</p>
<p name="24e5" id="24e5" class="graf graf--p graf-after--p">All we have to do now is tell our <code class="markup--code markup--p-code">CatFact</code> class to call this method every time a new <code class="markup--code markup--p-code">CatFact</code> is created. Add the following near the top of your <code class="markup--code markup--p-code">CatFact</code> class:</p>
<pre name="ada9" id="ada9" class="graf graf--pre graf-after--p">after_create :notify_subscribers</pre>
<p name="92bc" id="92bc" class="graf graf--p graf-after--pre">Now every time an instance of <code class="markup--code markup--p-code">CatFact</code> is created the <code class="markup--code markup--p-code">notify_subscribers</code> method will be called, and all of our subscribers will be notified.</p>
<h3 name="67c8" id="67c8" class="graf graf--h3 graf-after--p">Putting it all together</h3>
<p name="1902" id="1902" class="graf graf--p graf-after--h3">We are now ready to test out our app and see if it works as intended.</p>
<ul class="postList">
<li name="41fb" id="41fb" class="graf graf--li graf-after--p">Fire up your <code class="markup--code markup--li-code">rails server</code> (if it isn’t still running)</li>
<li name="53e8" id="53e8" class="graf graf--li graf-after--li">In your browser navigate to <a href="http://localhost:3000/cat_facts" data-href="http://localhost:3000/cat_facts" class="markup--anchor markup--li-anchor" target="_blank">http://localhost:3000/cat_facts</a>
</li>
<li name="c292" id="c292" class="graf graf--li graf-after--li">Fill out the form with a new cat fact and hit Create</li>
<li name="8ce7" id="8ce7" class="graf graf--li graf-after--li">You (along with anyone else who subscribed to your app) should receive a text message with your new fact!</li>
</ul>
<h3 name="f1e5" id="f1e5" class="graf graf--h3 graf-after--li">Conclusion</h3>
<p name="3f7e" id="3f7e" class="graf graf--p graf-after--h3">That was really cool, feel free to play around with it and see what other features you can add (for example, in my Alternate Side Parking bot users can call in to get the latest status as well).</p>
<p name="5cac" id="5cac" class="graf graf--p graf-after--p">The Twilio documentation is very friendly and easy to use, they even have a game called <a href="https://www.twilio.com/quest" data-href="https://www.twilio.com/quest" class="markup--anchor markup--p-anchor" rel="noopener" target="_blank">TwilioQuest</a> to help you get started!</p>
<p name="182c" id="182c" class="graf graf--p graf-after--p">If you want to see the code for the app we just built, you can check out the repo on <a href="https://github.com/achasveachas/twilio_cat_facts" data-href="https://github.com/achasveachas/twilio_cat_facts" class="markup--anchor markup--p-anchor" rel="noopener" target="_blank">GitHub</a>.</p>
<p name="3963" id="3963" class="graf graf--p graf-after--p graf--trailing">And as a final reminder, if you live in NYC feel free to follow <a href="https://twitter.com/AlterSideBot" data-href="https://twitter.com/AlterSideBot" class="markup--anchor markup--p-anchor" rel="noopener" target="_blank">@AlterSideBot</a> or text <strong class="markup--strong markup--p-strong">SUBSCRIBE</strong> to 347–404–5618 to get SMS notifications whenever Alternate Side Parking rules are suspended.</p>
</div>
</div></section>
</section>