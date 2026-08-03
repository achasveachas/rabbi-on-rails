---
title: "Don't Refuse the Gift: Where Friction Belongs in the Age of AI"
date: 2026-08-03 00:00:00 +0000
tags:
  - torah-tech
  - ai
  - learning
---

I recently wrote [a post](/learning-and-teaching-in-the-age-of-ai) about the critical role friction plays in the learning process, and how AI seems uniquely designed to bypass it entirely. This seemingly leaves us in a Catch-22.

On the one hand, we all know that real engineering skill comes from friction. You build cognitive neural pathways by banging your head against a `NullPointerError` at 2 AM, hunting down a typo on line 22, and wrestling with syntax until it finally clicks. 

When you outsource all of that productive struggle to an LLM, your debugging skills, much like your leg muscles if you drive down the block instead of walking, quietly atrophy (easy come, easy go).

On the other hand, if you stubbornly refuse to use AI, you aren't training in the actual workflows you will undoubtedly use in your day-to-day job. It borders on professional malpractice to ignore a tool that can boost your productivity and velocity so much. 

So how do we reconcile the two? How do we embrace the boost that modern AI tools give us without losing the friction required to actually grow as developers?

### The Rebbe’s Gift

While thinking about this the other day, I was reminded of a 200-year-old story involving Rabbi Shneur Zalman of Liadi (the founder of the Chabad Chassidic movement, affectionately known as the *Alter Rebbe* or "Old Rabbi") and his young grandson, Rabbi Menachem Mendel (who would later become a revered scholar and the third Rebbe of Chabad, known for his series of books, the *"Tzemach Tzedek"*).

The Alter Rebbe raised his grandson, who was orphaned at the age of three, and personally oversaw his education. One day, the Alter Rebbe made his grandson an incredible offer: “I want to give you all the Torah knowledge I possess as a present.”

To his grandfather's surprise, the young boy politely declined. 

He explained that he preferred to acquire his knowledge through his own _Yegiah_ (a Hebrew term that translates to intense intellectual toil, effort, and sweat). He knew that knowledge handed over on a silver platter would never truly belong to him the way knowledge earned through rigorous struggle would.

Usually, inspirational stories end right there with an obvious, tidy moral: *“And the boy refused the easy way out because hard work is magical!”* 

But the story *doesn't* end there.

Years later, when the grandson had grown into a brilliant leader in his own right, he looked back on that childhood moment with deep regret. 

“I should have accepted the gift from my holy grandfather.” he remarked, “As far as my concern about _Yegiah_ — Torah is infinite, so as much Torah knowledge as he would have given me, there would always be room to toil on top of that!”

### Moving the Friction Up the Stack

Nice story, but what does an exchange from two centuries ago have to do with AI?

That hindsight realization the Tzemach Tzedek had, that's the exact blueprint we need for navigating software development in 2026.

AI coding assistants are an amazing gift. By automating a lot of the boilerplate, they offer us a massive boost in productivity. They can generate database migrations and write standard CRUD endpoints in seconds. 

We shouldn't gatekeep the industry or force ourselves (and the juniors coming up behind us) to reject this gift out of some misplaced sense of purity (we don't write Assembly on punchcards anymore and we shouldn't force juniors to use vim). Take the present! Let the AI write the boilerplate so you can move faster.

**However: we still need the _Yegiah_.** 

The mistake isn't using AI to write code; the mistake is letting AI eliminate our intellectual toil entirely. Instead of refusing the gift, we simply need to move our *Yegiah* up a level.

When you let an LLM generate a complex module, your cognitive friction shouldn't be spent remembering standard syntax or matching closing brackets. Your *Yegiah* should shift to higher-order engineering:

*   **Architectural Skepticism:** *Why* did Claude structure the data this way? Does this pattern actually scale under load, or is it just the most statistically common answer on GitHub? `(Spoiler: it's usually the latter.)`
*   **Security & Edge Cases:** Where are the subtle race conditions? What happens when this endpoint gets hit with malformed data by a bored script kiddie (who is probably using AI as well)?
*   **Domain Mastery:** Can I clearly explain every single line of this generated code to a junior developer without looking at the screen?

By accepting the baseline gift of AI, we free ourselves from spending our intellectual energy reinventing the wheel. But if we want to become true masters of our craft, we have to take that extra bandwidth and reinvest it in the deep, rigorous *Yegiah* of solving harder, more human problems.

So remember, take the gift, but don't forget to sweat as well.