---
title: "The Friction Is A Feature, Not A Bug: Teaching and Mentoring in the Age of AI"
date: 2026-07-22 00:00:00 +0000
permalink: /learning-and-teaching-in-the-age-of-ai
description: What happens to junior developers when we outsource the Socratic method to an LLM? A reflection on AI yes-men, Chavrusa learning, and whether prompt engineering can ever replace human empathy.
tagline: Why Socratic mentorship, active debugging, and human empathy can't be prompt-engineered away.
header:
  overlay_image: /assets/images/posts/robo-teacher.jpg
  teaser: /assets/images/posts/robo-teacher.jpg
  header: /assets/images/posts/robo-teacher.jpg
tags:
  - mentorship
  - ai
  - reflections
  - learning
---

Those who have been following me for a while will know that teaching and mentoring [are a Big Deal™️](/tags/#mentorship) to me.

Before I got into tech I was a teacher, and still consider myself a teacher at heart. Being a teacher and mentor [was never separate](/are-you-a-10x-engineer-348aa74c82d5) in my eyes from being a good programmer and engineer; on the contrary, teaching was a tool that helped me become better at my craft at every stage of the journey.

But in the last few years, and accelerating in the last few months, the landscape for teaching and learning has been changing at a scary pace. The advent of LLMs and "AI" coding assistants has drastically shifted how we acquire engineering skills in ways that we are definitely not prepared for.

All of that has prompted many thoughts and conversations, and I hope to distill some of them in this blog post.

In true Talmudic fashion, this post doesn't contain too many answers and will hopefully leave you with more questions than you started with. But asking the questions is how we start these conversations, and these conversations *need* to be happening if we are to do right by the coming generation of programmers and engineers.

### Don't Spoon-Feed Me

As a student, whether in Yeshiva when I used to spend hours each day poring over dense Talmudic legal debates and esoteric Chassidic philosophy or later while learning Rails and React at the Flatiron bootcamp, I quickly realized an uncomfortable truth about skill acquisition. 

My best, most profound learning never happened when a lesson went smoothly; it happened when I was painfully stuck, banging my head against a cryptic error message or wrestling with a concept that just wouldn't click (usually at 2 AM, fueled by cold coffee and sheer stubbornness).

![A programmer sitting in front of a computer with a thoughtful look on their face with a caption "it doesn't work... why?" followed by a panel with the same programmer in the same position but this time the caption reads "It works... why?" ](/assets/images/posts/it-works.png)

When you strip away that struggle, you get rid of the growth. And when you get rid of the growth, the learning just doesn't happen.

Even if you memorize just enough to pass the test, "easy come easy go." Without that cognitive friction, the knowledge evaporates the moment you close your editor.

The best teachers and mentors I ever had understood this intuitively. When I was staring at a broken script knowing there was probably a stupidly easy fix, they didn’t just swoop in and drop the solution onto my screen (much to the vocal frustration of my sleep-deprived brain). 

Instead, they wielded tools like the Socratic method. They would point to a specific line of code and start asking gentle, probing questions to expose my flawed assumptions.

They actively leaned into the friction to create just enough cognitive space for me to connect the dots on my own.

They understood a fundamental rule of our teaching craft: that good mentorship is not about getting to the code. The goal wasn't just to get the tests turning green today; it was to build the mental resilience required to debug the _next_ inevitable failure tomorrow.

And it was these skills that I took with. me when it was _my_ turn to become the teacher, whether it was teaching second graders at the Jewish Online School, as a TA at Flatiron, or when mentoring new teammates joining my team.

### The Yes-Man in Your IDE

Fast forward to today, and our industry has largely outsourced that initial layer of mentorship to LLMs and coding assistants. And here is the uncomfortable truth: AI makes a terrible Socratic tutor.

![Will Smith asks a robot "why did you just delete the production database?" and the robot answers "you are absolutely right to push back. Your eagle-eyed observation caught my mistake."](/assets/images/posts/ai-pushback.jpg){: .align-center} 

If you’ve spent any serious time pairing (or even just chatting) with modern LLMs, you know they are pathological yes-men. Tell an AI you want to architect a distributed microservice mesh for a todo-list app with twelve active users, and it won't push back. It will chime in with "That is a brilliant insight!" and instantly spit out 400 lines of boilerplate.

AI defaults to blind trust. It rarely challenges a mistaken assumption, and when you ask it why a stack trace is blowing up, it immediately serves up a copypastable fix instead of helping you understand the underlying bug.

By acting like an algorithmic vending machine (`error_in => fix_out`), AI systematically removes all the cognitive friction from the development process. 

In our rush for 10x velocity, we forgot a foundational rule of skill acquisition: friction is a feature, not a bug. That was a load-bearing friction we removed!

This isn't just philosophical speculation; there's hard data to back it up. A recent [study by Anthropic](https://www.anthropic.com/research/AI-assistance-coding-skills) (or dive into the [raw paper here](https://arxiv.org/abs/2601.20245) if you love parsing methodology) took 52 software engineers learning an unfamiliar programming library and split them into two groups: one with AI coding assistants, and one coding by hand. 

The overall results were as damning as they were not surprising. The engineers who delegated their coding to AI suffered a 17% drop in conceptual mastery and debugging skills (the equivalent of two full letter grades!) often without completing their tasks meaningfully faster than the manual control group. 

Why? Because when you offload the cognitive friction of getting painfully stuck, your brain never builds the deep neural pathways required to evaluate whether the generated code is actually any good.

Now, to be fair, there *was* some nuance in the data: a handful of the AI-assisted engineers actually outperformed the manual control group. But who were they? They were the developers who refused to trust the AI blindly. They treated the LLM like a study partner, asking probing follow-up questions and manually injecting their own friction back into the process. 

For everyone else, the automated yes-man just quietly destroyed their understanding.

### The Learner’s Dilemma: Manually Injecting Friction

This dynamic leaves junior developers in a massive bind. 

Friends and mentees who are earlier in their career [have complained](https://madelinecaples.hashnode.dev/how-do-i-use-ai-in-my-learning) that they feel stuck in a frustrating Catch-22: 

On one hand, they have to pragmatically accept the reality that AI isn't going anywhere. If an LLM can generate working boilerplate from a single prompt, you can't just stubborn your way out of using it. Ignoring AI entirely feels irresponsible, considering that you will be using these tools heavily in your day-to-day workflows.

But on the other hand, if you rely on that autocomplete blindly, you get trapped in what's known as "superficial learning." You get a quick answer that allows you to pass a test suite or get a PR approved without truly understanding the mechanics under the hood. You miss out on the "deep learning" where the actual, career-sustaining growth happens.

In my experience, that superficiality is a direct pipeline to developer anxiety and impostor syndrome. True professional confidence doesn't come from hitting Tab to accept a prompt; it comes from code ownership and intense intellectual toil and sweat.

To survive this, diligent learners are now being forced to manually inject friction _back_ into their workflows just to keep their brains from turning off.

A junior developer friend of mine [has resorted](https://madelinecaples.hashnode.dev/learning-at-ruby-conf-a-workflow-for-ai-assisted-study) to explicitly prompting their IDE with guardrail instructions like: "I want to learn how to code it myself, rather than copying and pasting, so enable that however you can."

They take notes by hand (yes, actual paper and pen!) and set physical timers just to recreate the safeguards of active listening that a tool designed for instant gratification systematically tries to bypass.

### Why We Need the Messy Web of Context

This need for self-imposed struggle makes total sense when you look at Emily Bender and Alex Hanna’s book, [The AI Con](https://thecon.ai/), which highlights why friction in information access is actually a feature, not a bug.

Think about what happens when you manually hunt down an obscure bug using a search engine.

You read messy documentation, scan through twelve-comment GitHub issue threads (usually ending with a maintainer closing it as "not a bug" in 2014), weigh the credibility of conflicting answers on Stack Overflow, and stumble across related gotchas along the way.

That messy web of meta-information is where real engineering context is built.

An AI chatbot flattens all of that rich, frustrating struggle into a single, authoritative-sounding (and occasionally "hallucinated") summary. It gives you the answer to your immediate problem while robbing your brain of the surrounding ecosystem knowledge required to solve the next one.

### The Chavrusa Model: Pair Programming && The Adversarial Rubber Duck

This brings me to an ancient pedagogical model that survives to this day in Yeshivas (Talmudic academies) around the world, and one that software engineering desperately needs right about now.

In a traditional Yeshiva, you rarely see people sitting in silent isolation reading a book or passively listening to a lecture. Instead, the room is loud, energetic, and filled with people arguing fiercely in pairs.

![A group of rabbis arguing over a book of Talmud. ](/assets/images/posts/talmud.jpg)

This study partner system is known as a [Chavrusa](https://en.wikipedia.org/wiki/Chavrusa) (from the Aramaic word for "friend" or "companion").

When you learn with a Chavrusa, your partner isn't there to read the text to you, nor do they nod along and sycophantically affirm how brilliant your theories are. A real Chavrusa regularly challenges your logic, pokes holes in your arguments, pushees back against shaky assumptions, and generally refuses to let you get away with intellectual laziness.

You don't master the Talmud by reading cliff notes or listening to a brilliant lecture (though there's some of that as well); you master it through _Yegiah_ (a Hebrew term that translates to intense intellectual toil and sweat).

If you think about it (and as I mentioned in my [2021 RailsConf talk](/talmudic-gems-for-rails-developers-77f6cb98c9ad)), pair programming is just the tech industry's recreation of the Chavrusa.

And here is the most important part of that system: it's not only the junior member of the pair who's learning in a true Chavrusa.

It doesn't matter if you are pairing with a 10-year staff engineer or a junior developer who just finished a bootcamp; the learning is always a two-way street!

When your partner acts as an adversarial rubber duck (one that actually talks back!), they force you to slow down, articulate your hidden assumptions, and defend your code logic from start to finish. Both of you gain from that friction, and both of you walk away with a significantly better mental model than you started with.

> Rabbi Ḥama, son of Rabbi Ḥanina, said: What is the meaning of that which is written: “Iron sharpens iron, so a man sharpens the countenance of his friend” _(Proverbs 27:17)_? This verse comes to tell you that just as with iron blades, one sharpens the other when they are rubbed against each other, so too, when Torah scholars study together, they sharpen one another.
>
> _-Ta'anit 7a_

![Close up of two blades n a sword fight hitting against each other. ](/assets/images/posts/karori-production-6qRACL2DquI-unsplash.jpg)

In our rush for 10x velocity, we tried to replace human pair programming with AI copilots. But in doing so, we forgot a critical dependency: we exchanged the adversarial Chavrusa and Yegiah for a sycophantic robo-duck.

### Empathetic Balancing Act

A common response I hear from the tech crowd is: "Well, let's just fix this with better system prompts! Let's build guardrails that instruct the AI to act like a Socratic tutor instead of just giving away the answer!"

There are plenty of tools attempting this right now, but I am deeply skeptical that technical guardrails can solve a fundamentally human problem.

First of all, relying on a prompt to withhold answers requires elite learner discipline. Some students can stick to it, but that level of willpower is rare, especially when your cognitive battery is hitting empty.

When a junior developer is staring at a cryptic `NullPointerException` at 2 AM and their brain is fried, a prompt asking them to "reflect on the lifecycle of the object" is getting bypassed immediately. If all it takes is typing `/solution` or opening a new browser tab to get the dopamine hit of copypastable code, not too many people I know will power through.

More importantly, LLMs are fundamentally architected to please. Even if you prompt-engineer them to be tough Socratic tutors, their core tuning means that the moment a user expresses genuine frustration, the AI folds like a cheap lawn chair and hands over the syntax anyway.

Why? Because an LLM lacks the quality most important in an educator: *empathy*.

Mentorship is a human pedagogical balancing act. A great mentor understands the fine line between productive struggle and demoralizing suffering. A good educator can read the room. They notice the heavy sighs, the mounting panic, and the sheer exhaustion.

Sure, as a student I learned best when I was given the tools to figure things out on my own. But sometimes I maxed out my energy on the stupid error message, and all of the leading questions my tutors were asking me felt like they were just causing me to circle and circle around the one insight that would make it all work, an insight my brain just couldn't reach.

That is the point a good teacher knows to step back, smile, say "Hey, JavaScript is just weird sometimes," and hand the exact line of code I needed to get unstuck so I could finally go get some sleep.

An algorithm cannot read a learner's emotional state. It cannot dynamically toggle between a challenging sparring partner and a supportive safety net. Code can never replicate that relationship.

![A teacher and students engaged in a collaborative learning activity in a classroom. The teacher is writing something in the student's notebook. ](/assets/images/posts/pexels-ai25studioai-5306457.jpg)

### The Unsolved Catch-22

So where does this leave us? If I’m being entirely honest, I have way more questions than answers right now (not exactly what you want to hear from a tech blog, I know!).

We are sitting on a massive, industry-wide Catch-22:

On one hand, it would be borderline professional malpractice to forbid junior developers from using AI. It is the modern IDE (which, back when I was learning to code, gatekeepers argued juniors shouldn't use either—I disagreed then and I disagree now). If juniors will be expected to use these tools on the job, it hardly makes sense not to train them to use them effectively.

On the other hand, the engineers getting that massive 10x velocity boost without introducing architecture-destroying bugs are the seniors who spent years writing code _without_ it.

_We_ know when an LLM is spinning its wheels on a false premise because _we_ have a built-in BS-meter, hard-earned through years of manual debugging.

How does someone without that pre-AI experience build that intuition today? They won't get it from a sycophantic yes-man chat-bot assistant. And manually inventing your own cognitive friction requires a level of self-discipline that is hard to maintain on a tight deadline.

Maybe the future of onboarding relies on doubling down on human pair programming—having juniors shadow seniors for months on end to soak up that pre-AI intuition by proxy. After all, pair programming has _always_ been one of the best onboarding methods, even before Claude. But not all companies are interested in the investment that full-time pairing requires in an industry often obsessed with shipping yesterday.

What I do know is that we cannot afford to ignore the problem or assume that better LLM models will magically fix our talent pipeline.

If we just hand junior developers an oracle and fail to preserve the empathetic, rigorous struggle of the Chavrusa, we are going to wake up in a few years to a terrifying system error: an industry with a massive, AI-generated codebase to maintain, and not enough senior engineers left who know how to maintain it.

What are you and your teams doing to keep productive friction alive? I'd love to hear your thoughts.
