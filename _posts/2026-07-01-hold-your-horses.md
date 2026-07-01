---
title: "Hold Your Horses: A 200-Year-Old Lesson on AI"
date: 2026-07-01 00:00:00 +0000
permalink: /hold-your-horses
description: "Is AI a magic wand or a useless toy? Here is what a 200-year-old Chassidic story taught me about steering the AI hype and learning to ride the horse."
header:
  teaser: /assets/images/posts/robotic-horse.jpg
tags:
  - torah-tech
  - ai
  - reflections
---

### To AI Or Not To AI

If you follow the tech world these days, you’ve probably noticed that there is absolutely no middle ground when it comes to Artificial Intelligence.

On one side, you have the AI evangelists claiming that AGI is basically here, you’ll be replaced in six months (for the past two years), and you should be letting AI write your entire codebase based on vibes only or risk being left behind.

On the other side, you have the AI doomers who point at AI's inability to count the "R"s in "strawberry" and its tendency to be wrong so confidently it puts mediocre white men to shame and proudly declare the technology to be a useless, glorified autocomplete.

The reality, as always, contains a little bit of both.

![both is good](https://media1.tenor.com/m/PLeWlGFYpIAAAAAd/both-is-good.gif)

AI is neither a magic wand that does your job for you and will solve all the world's problems, nor is it completely useless. It could be a massive force multiplier. But in software engineering, as in life, speed is only useful if you are actually heading in the right direction.

### Horsing Around

To understand where AI really fits into our toolbelts, I like to think of a story about Rabbi Shneur Zalman of Liadi known as the Ba'al HaTanya ("Author of the Tanya") for his seminal work by that name.

Rabbi Shneur Zalman lived in present-day Belarus in the late 1700s and founded the Chabad chassidic movement. He was renowned not just as a mystic and a scholar, but as a deeply practical advisor. People would travel and correspond with him from all over to consult with him on their personal struggles.

One day, a father came to the Rebbe. His teenage son was turning away from his upbringing and values. Instead of focusing on his studies, the boy was spending all his time at the local stables, obsessing over horses and galloping around the countryside. The father wasn't happy with his son's new hobby and asked the Rebbe for advice.

The Rebbe advised the father to find an excuse to send the boy into town so they could meet. Knowing his son loved to ride, the father gave him an errand at the Rebbe's court and told him he could ride his horse there. The young man happily galloped into town, eventually finding himself face-to-face with the Rebbe.

"Why did you choose to ride into town on a horse instead of taking a carriage?" the Rebbe asked.

"Because a good horse runs fast," the boy replied enthusiastically. "You gallop away, and you reach your destination so much quicker."

"That is all very well," the Rebbe countered. "But if you make a wrong turn, then you end up traveling quickly in the wrong direction and get completely lost!"

The young man thought for a moment and pushed back. "That may be true, Rebbe," he insisted, "but as soon as you catch yourself and see that you are on the wrong path, the horse can help you quickly get back on the road."

"Yes," the Rebbe repeated slowly and emphatically. "If you realize you're on the wrong path before it is too late, you can quickly return to the main road..."

![Scrap metal horse sculpture in a field.](/assets/images/posts/robotic-horse.jpg)

### The Artificial Horse

This story captures the reality of coding with Large Language Models.

LLMs give us unprecedented velocity, but they don't actually understand *why* we are building things. It is raw, untamed horsepower.

Just the other day, I was using Claude to help write some controller tests for a web app. The test failed because the endpoint returned a `401 Unauthorized`, which made sense, we hadn't set up an authenticated user in the test setup yet.

Instead of figuring out how to properly mock a logged-in user, Claude decided to take the fastest possible route to a green test suite. It rewrote the test to expect a `401 Unauthorized` and proudly declared the test passed "because we know the controller is working."

![A Windows dialogue that says "Task failed successfully."](/assets/images/posts/task-failed.jpg)

This is exactly what the Alter Rebbe meant. The AI horse galloped to the destination at lightning speed and got the test passing, but in completely the wrong direction.

If you just blindly click "Accept" (or worse, run Claude with `--dangerously-skip-permissions` 😱), AI will confidently help you write terrible code, introduce subtle (and not so subtle) security flaws, or "fix" tests by defeating their entire purpose, all faster than you can type.

### Hold The Reins Tight

But the young man in the story was right as well: if you realize you've made a mistake, the horse helps you pivot fast.

An experienced engineer will know when to pull the reins. When Claude tried "fixing" my test and I told it, *"No, we need to actually authenticate a user before making the request."* It instantly generated the correct setup block, and got us back on the right path just as quickly as we had left it.

The horse isn't the enemy, but it also isn't going to get you to your destination on its own.

In the hands of someone who doesn't know how to code, AI is just a fast ride in the wrong direction. But in the hands of an engineer who knows its strengths and its limitations it is an incredible tool.

Don't be the developer who blindly trusts the horse to do the architectural thinking for you. And don't be the developer who stubbornly refuses to ride, insisting on walking on foot while everyone else is galloping.

Don't fear the horse. Just keep your hands on the reins, constantly check your map and compass, and be the rider.
