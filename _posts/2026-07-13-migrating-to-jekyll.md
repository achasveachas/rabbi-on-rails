---
title: "The Strange Case of Migrating My Blog to Jekyll"
date: 2026-07-13 00:00:00 +0000
permalink: /migrating-to-jekyll
description: "After years of splitting content between Medium and DEV, I finally moved everything to a self-hosted, version-controlled Jekyll site. Here is the why, the how, and the technical hurdles of the migration."
header:
  teaser: /assets/images/posts/jekyll-6.png
tags:
  - writing
  - ruby
  - jekyll
  - blogging
---

It finally happened. I got the corporate ransom note.

Back when I started learning programming, I wanted a place to share my learnings, and that's how ["Rabbi on Rails" was born](/puts-hello-world-a55de12047d5).

At the time, Medium was a perfectly reasonable place to host my blog. It looked clean, handled formatting well enough, and had a built-in network effect (some of my blog posts got tens of thousands of views and I still don't know why). But over the last few years, we’ve all watched the slow, painful "enshittification" of third-party publishing platforms. Paywalls went up and algorithms got aggressive. Still, I stayed. Change is hard, and as long as Medium technically worked, migrating remained a background task to be tackled "some day."

Then the final straw landed in my inbox: Medium was making changes to their DNS, and as part of those changes, I was going to lose my custom domain unless I upgraded to a paid plan. 

Another ongoing pain point was that my writing had become fractured. At some point, I started posting my "Torah && Tech" articles (along with other posts of Jewish/religious interest) on my Rabbi on Rails Medium blog, while my more technical posts went to my [DEV.to profile](https://dev.to/yechielk). There was some overlap (a few articles were cross-posted) but there were no clear rules on what went where, and worse, I didn't truly own any of it.

So recently, I decided it was finally time to take back ownership of my content, my platform, and my domain. 

Here is the story of how I migrated both of my blogs into a single self-hosted, static Jekyll site, and the technical headaches I encountered along the way.

## Choices, Choices...

So I knew I wanted to migrate _off_ of Medium, but where should I migrate _to_?

Of course, I could take the easy path and pick a new platform like Hashnode or Ghost, but that would run the risk of finding myself back in the same place in a year or two when they inevitably change their terms and I have to migrate _again_.

Clearly, it was time to finally self-host.

The timing was right as well. A few years ago, going the self-hosting route would have required a significant time investment—from researching frameworks to spending hours on "just one little tweak" that would send me down a CSS rabbit hole. But these days, with the ubiquity of LLMs, I figured the process of creating a blog (very much a solved problem) should be trivial to accelerate.

Sure enough, my guess paid off. Within half an hour, I had all the information I needed to choose. My blog would be hosted on GitHub Pages using [Jekyll](https://jekyllrb.com/) as the framework and [Minimal Mistakes](https://mmistakes.github.io/minimal-mistakes/) for the theme.

## Why Jekyll?

When choosing a platform, I had a few criteria.

First and foremost, I wanted control over the platform and the content for the reasons I already mentioned. But within the world of self-hosting, there are a million ways to go, so I had to narrow things down.

As a busy (and somewhat lazy 🙃) developer, I didn't want to spend three weeks building a custom React or Next.js blogging engine from scratch, nor did I want to navigate the mess of modern JavaScript framework fatigue just to display static text. I wanted something stable, battle-tested, inherently secure, and low-maintenance, requiring me to write as little code as possible.

Seeing how the theme of the blog is "Rabbi on Rails," **Jekyll**, built in Ruby, was the obvious choice. 

It integrates natively with GitHub Pages (meaning zero-cost hosting), uses standard Liquid templating, and handles simple Markdown files. To keep from reinventing the wheel layout-wise, I pulled in the **Minimal Mistakes** theme, which gave me a sleek, responsive design, an author sidebar, and clean typography right out of the box.

Most importantly, everything now lives in a [Git repository on GitHub](https://github.com/achasveachas/rabbi-on-rails). My blog posts are version-controlled. If I make a catastrophic formatting mistake, I don't rely on a platform's fragile history UI; I just run `git revert`. Plus, every post includes a built-in "Suggest a Fix" button that drops readers directly into the GitHub web editor to submit a PR. Even the reactions and comments on posts are handled via GitHub Discussions using [giscus](https://giscus.app/).

## Scripting The Migration: The Fun Part

Setting up the blog using Jekyll was the easy part. Actually extracting years of data from two completely different platforms and standardizing it into Jekyll-compatible Markdown is where the real engineering happened. 

Because I didn't want to copy and paste dozens of articles manually, I wrote custom Ruby scripts to handle the heavy lifting (if you're curious, you can find the scripts under the /scripts directory in the blog's repo). I quickly discovered that Medium and DEV each have their own pain points that torment migrating developers in completely opposite ways:

### 1. The Medium Export (The HTML Swarm)
When you export your data from Medium, they don't give you clean Markdown. They hand you a zip file full of raw, clunky HTML files. My migration script had to parse through these HTML nodes, strip out Medium-specific wrappers, extract the metadata for the frontmatter, and translate the core elements back into clean Markdown. Furthermore, they don't differentiate between different kinds of content: every blog post you wrote and every comment you ever left on anyone's article all get dumped into one massive folder with no built-in way to tell them apart.

### 2. The DEV.to Export (Liquid Tag Fun)
DEV.to is much friendlier on the surface; their export gives you actual Markdown files. However, the headache here was their proprietary ecosystem. DEV relies heavily on custom Liquid tags for embeds (like tweets, YouTube videos, GitHub gists, and other articles and comments on DEV). Because standard Jekyll doesn't understand DEV's specific tags, my script had to use a heavy dose of regex to scrub, translate, or strip those out into standard web embeds.

### 3. The Asset Trap (Owning the Images)
One critical rule of a true migration: **you must host your own images.** If you leave your blog post images pointing to Medium or DEV’s CDNs, you don't actually own your blog. If they change their CDN routing or delete your old account, your images break. 

My script didn't just transform text; it scanned every post, found the image URLs, downloaded the assets locally into an `assets/images/` directory, and rewrote the Markdown image paths to point to my repository.

## The Hyde Side of Jekyll: The Honest Tradeoffs

So far, the new setup is working fine for me, but every architectural change always comes with compromises. If you are thinking of making a similar move, you have to be comfortable with a few realities:

* **No Native Platform Visibility:** Medium and DEV have built-in audiences. When you publish on your own domain, you are shouting into the void until you distribute the link yourself. I plan on mitigating that a little by still cross-posting my technical posts on DEV (DEV makes it easy to add a canonical URL so your blog doesn't take an SEO hit). Of course that means I need to do a better job promoting new blog posts on LinkedIn and other platforms.
* **No Slick Web Editor:** Medium and DEV spoil you with smooth, browser-based WYSIWYG editors that feature instant previews and drag-and-drop image uploading. With a static blog, you say goodbye to all that. Writing a post now means opening your IDE, writing raw Markdown, manually saving image files into local asset folders, and pushing a git commit to publish. As a developer, I don't mind writing in my local code editor anyway, and VSCode plugins provide useful features like quick previews and syntax support. But you definitely lose the convenience of logging into a website from any computer and firing off a quick post.
* **No Built-in Interactions:** Out of the box, there are no "claps," likes, or comment sections. In order to have a way for users to interact, I used giscus which relies on GitHub's Discussions. That does mean that readers need a GitHub account to interact which works for an engineering crowd, but it means that my wife, who was my most consistent "clap" on Medium, probably won't be reacting to my Jekyll posts anymore :)
* **The Analytics Void:** Static sites on GitHub Pages have no backend server logs. If you want to track page views without involving massive, privacy-invasive trackers like Google Analytics, you have to get creative by switching to a server-side host like Cloudflare Pages or utilizing privacy-first, cookie-less scripts like GoatCounter. For me, that wasn't worth the hassle; I write primarily for myself and if others find my posts useful that's fine, so I'm okay just not collecting analytics and not knowing how many readers each blog post gets (if any).

## The Wins: Long Live the Indie Web

Despite the tradeoffs, the pros completely outweigh the cons. 

I have total ownership. I own the layout, the content, the deployment pipeline, and the domain. Everything is centralized under `blog.yechiel.me`. 

And the coolest unexpected side effect? The moment I published my first post, my RSS aggregator immediately pinged me. Because Jekyll natively builds a `feed.xml` file on every deploy, my RSS feed, which had been broken for ages by platform API shifts, instantly came back to life out of the box. 

It feels incredibly good to step off the platform carousel and return to the roots of the indie web. If you've been putting off migrating your own content because of the technical friction, take this as your sign: write the script, own your data, and take your domain back.