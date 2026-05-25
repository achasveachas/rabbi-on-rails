---
title: "I Challenge You Sinatra"
date: 2016-09-04 21:11:15 +0000
permalink: /2016-09-04_I-Challenge-You-Sinatra-c6f875e29db7
header:
  teaser: /assets/images/posts/2016-09-04-2016-09-04_I-Challenge-You-Sinatra-0.jpeg
tags:
  - 
categories:
  - 
---

<section data-field="body" class="e-content">
<section name="d975" class="section section--body section--first section--last"><div class="section-divider"><hr class="section-divider"></div>
<div class="section-content"><div class="section-inner sectionLayout--insetColumn">
<h3 name="5d67" id="5d67" class="graf graf--h3 graf--leading graf--title">I Challenge You Sinatra</h3>
<p name="391f" id="391f" class="graf graf--p graf-after--h3">I finally finished the Sinatra section of the <a href="http://learn.co/with/achasveachas" data-href="http://learn.co/with/achasveachas" class="markup--anchor markup--p-anchor" rel="noopener" target="_blank">Learn.co</a> curriculum, and that means I have to make a complete Sinatra app from scratch.</p>
<p name="7202" id="7202" class="graf graf--p graf-after--p">I’ve <a href="https://medium.com/coding-hassid/gem-install-swim-82ff7a95e605#.mip8xbsxj" data-href="https://medium.com/coding-hassid/gem-install-swim-82ff7a95e605#.mip8xbsxj" class="markup--anchor markup--p-anchor" target="_blank">blogged in the past</a> how being dropped into a project is the best way to learn about it, and this was true in this case as well; I’ve learned more Sinatra in the process of making this project than I did in the whole preceding section of lectures and labs.</p>
<p name="e8b1" id="e8b1" class="graf graf--p graf-after--p">The first step of course was coming up with an idea for my project, so last Shabbat I was talking to a developer friend and asked him if he had an idea for a Sinatra app I could make. He started rattling off different ideas and somewhere in between a blog and a fishing app he mentioned “…you could try a reddit clone… actually never mind, that’s probably too complicated…”</p>
<p name="f557" id="f557" class="graf graf--p graf-after--p">I didn’t need anything more than that, and immediately the my wheels started churning thinking of the the different features, models and associations my app would need.</p>
<p name="ff4d" id="ff4d" class="graf graf--p graf-after--p">As soon as Shabbat was out I headed straight to my computer and started putting the plan to action.</p>
<figure name="b789" id="b789" class="graf graf--figure graf-after--p"><img class="graf-image" data-image-id="1*DW7FPZ3kzTM5iijC7pZcgw.jpeg" data-width="1143" data-height="711" src="/assets/images/posts/2016-09-04-2016-09-04_I-Challenge-You-Sinatra-0.jpeg"><figcaption class="imageCaption">Freddit home screen</figcaption></figure><p name="2596" id="2596" class="graf graf--p graf-after--figure">Usually the hardest part is getting started, thankfully this was taken care of by my side project; the Scaffold generator I built for the Corneal gem (read about it <a href="https://medium.com/coding-hassid/of-scaffolds-and-gems-140bdbe2e005#.5otcmzvdn" data-href="https://medium.com/coding-hassid/of-scaffolds-and-gems-140bdbe2e005#.5otcmzvdn" class="markup--anchor markup--p-anchor" target="_blank">here</a>).</p>
<p name="cabe" id="cabe" class="graf graf--p graf-after--p">My reddit app (which I called “freddit” after Flatiron’s naming convention that gave us “<a href="https://github.com/achasveachas/sinatra-fwitter-group-project-v-000" data-href="https://github.com/achasveachas/sinatra-fwitter-group-project-v-000" class="markup--anchor markup--p-anchor" rel="noopener" target="_blank">fwitter</a>”) is a very basic clone. It has users that can sign up, log in, start threads called Conversations, reply to other user’s Conversations, edit posts, and some other features which I will describe later.</p>
<p name="9b8b" id="9b8b" class="graf graf--p graf-after--p">The complexities came up in the details. I had to come up with methods that would tell my app which user was logged in, and only allow the posts and conversations to be edited by the user that created them.</p>
<p name="59d2" id="59d2" class="graf graf--p graf-after--p">It got more complicated when I allowed certain users to be “moderators” with the ability to edit posts by any other user, and even to ban a user when needed.</p>
<figure name="9af1" id="9af1" class="graf graf--figure graf-after--p"><img class="graf-image" data-image-id="1*0y-HiB3vT67FA4h7ht7aPQ.jpeg" data-width="1068" data-height="298" src="/assets/images/posts/2016-09-04-2016-09-04_I-Challenge-You-Sinatra-1.jpeg"><figcaption class="imageCaption">Banned user</figcaption></figure><p name="84cb" id="84cb" class="graf graf--p graf-after--figure">Handling all of this complexity led to some pretty ugly looking code, but thanks to some really helpful friends and the great instructors at <a href="http://learn.co/with/achasveachas" data-href="http://learn.co/with/achasveachas" class="markup--anchor markup--p-anchor" rel="noopener" target="_blank">Learn.co</a> (shout out to MendelB!) I was able to refactor it to something a little more manageable.</p>
<p name="5199" id="5199" class="graf graf--p graf-after--p">If you want to take a look at the code you can find it on <a href="https://github.com/achasveachas/freddit" data-href="https://github.com/achasveachas/freddit" class="markup--anchor markup--p-anchor" rel="noopener" target="_blank">GitHub</a>. I would really appreciate any feedback you can offer.</p>
<p name="53a3" id="53a3" class="graf graf--p graf-after--p graf--trailing">Happy coding!</p>
</div></div></section>
</section>