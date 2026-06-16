---
title: "Adding HTTPS To GitHub Pages Using A Custom Domain"
date: 2018-02-04 02:34:18 +0000
permalink: /adding-https-to-github-pages-using-a-custom-domain-7e4ee8ab1c50
header:
  teaser: /assets/images/posts/2018-02-04-2018-02-04_Adding-HTTPS-To-GitHub-Pages-Using-A-Custom-Domain-7.jpg
tags:
  - writing
  - learning
categories:
  - 
---

* * *

### Adding HTTPS To GitHub Pages Using A Custom&nbsp;Domain

**_Edit 5/1/2018:_** _As of today this blog post is out of date. Today GitHub announced it would be adding HTTPS support for custom domains using GitHub pages. See_ [_this post_](https://blog.github.com/2018-05-01-github-pages-custom-domains-https/) _for information on how to configure your GitHub Pages to use HTTPS._

I just did my part to make the web a safer place; I updated [my website](https://yechiel.me/) to work over HTTPS.

![](/assets/images/posts/2018-02-04-2018-02-04_Adding-HTTPS-To-GitHub-Pages-Using-A-Custom-Domain-0.png)

Websites that are served over HTTPS encrypt all communications between the server and the browser, so anyone trying to listen in on the traffic will just see a garbled meaningless string of text, instead of information that should probably be private, like passwords, credit card numbers, personal information, and that cat gif your aunt shared with you.

_(Side note: even though my personal website does not collect or display any sensitive information, encrypting it with HTTPS still makes the web a safer place for everyone, because the more “regular” traffic is encrypted, the harder it gets for malicious actors to figure out which encrypted traffic contains sensitive data. That is why you should probably set up your website to use HTTPS as well if you haven’t yet)._

I wanted to update my website to HTTPS for a while now, but I host my site on GitHub Pages, and GitHub Pages doesn’t support HTTPS for websites using custom domains.

Recently I learned that I could use Cloudflare to add HTTPS to my website. There are many tutorials out there that show how to do it, but I noticed that a lot of the information out there is a bit out of date (including some of the information on Cloudflare) so I decided to write up how I did it.

#### What Is Cloudflare?

Cloudflare is a service that gets between your users and your website and protects your site from certain kinds of attacks. What they do is, they route all the traffic to your website through their servers, and keep out traffic they feel is malicious.

![](/assets/images/posts/2018-02-04-2018-02-04_Adding-HTTPS-To-GitHub-Pages-Using-A-Custom-Domain-1.png)

One of the services they offer is, they allow you to use their SSL certificates even for websites that don’t have SSL certificates. So what will end up happening is that when a user visits your site any traffic between the visitor and Cloudflare will be secured using HTTPS, and then Cloudflare will route the traffic to your server using regular HTTP. That isn’t perfect, you probably shouldn’t use it if your website does collect sensitive data, but for a regular static site (like most GitHub Pages websites) that should be enough.

As a bonus, Cloudflare offers many more features to make your website safer, more reliable, and faster.

#### How Do I Do&nbsp;It?

The first step is to get your free Cloudflare account.

Once your account is set up, you will be prompted to add your domain. Once you enter your domain name, Cloudflare will do the rest; it will scan the DNS records and set most of it up. The only thing you have to do is update the nameservers with whoever owns your domain (GoDaddy, Google Domains, etc.) That process is different for each registrar, so check with them if you need help.

![](/assets/images/posts/2018-02-04-2018-02-04_Adding-HTTPS-To-GitHub-Pages-Using-A-Custom-Domain-2.png)

Once you update the namespace information with your registrar the status of your account will change to Active, you will now have to wait for Cloudflare to issue an SSL certificate for your domain. The process can take up to 24 hours for free accounts, but in my experience, it happened almost immediately. You can check the status by going to the Crypto tab in your dashboard; you should see “Status: Active Certificate” under SSL:

![](/assets/images/posts/2018-02-04-2018-02-04_Adding-HTTPS-To-GitHub-Pages-Using-A-Custom-Domain-3.png)

Once your SSL certificate is active, make sure you chose the right setting. There’s conflicting info out there because different tutorials were written by people with websites with various configurations, so here’s what you need to choose: if you use a custom domain with your GitHub Pages site, that means your website does not support HTTPS, and you should select “Flexible” SSL support. If, on the other hand, you are using the GitHub Pages domain (username.github.io) and you have SSL enabled then you should select “Full” SSL support (but not “Full (strict)”).

Once you have HTTPS working (you can test it by trying to visit your website and putting https in the URL instead of http), the next step is to ensure that anyone visiting your site uses only HTTPS and not HTTP. Most tutorials tell you to set up a page rule on Cloudflare, but it seems like they added that option as a setting to the Crypto tab, so you don’t have to use up one of your three free page rules.

![](/assets/images/posts/2018-02-04-2018-02-04_Adding-HTTPS-To-GitHub-Pages-Using-A-Custom-Domain-4.png)

Assuming you did everything right, you should now see the indicator in your browser telling you that your website is secure every time you visit it.

![](/assets/images/posts/2018-02-04-2018-02-04_Adding-HTTPS-To-GitHub-Pages-Using-A-Custom-Domain-5.png)

Congratulations! The web is now a safer place for all of us thanks to you!

#### Whoopsies!

I did run into one hiccup. My blog is in the same domain but is hosted by Medium which does use https, so when Cloudflare tried routing visitors to my blog using HTTP, Medium redirected them to HTTPS, which prompted Cloudflare to route them back to HTTP which prompted Medium… resulting in an infinite loop. The solution was to set a page rule for my blog.yechiel.me subdomain to tell Cloudflare to use the “Full SSL” setting just for that subdomain.

![](/assets/images/posts/2018-02-04-2018-02-04_Adding-HTTPS-To-GitHub-Pages-Using-A-Custom-Domain-6.png)

![](/assets/images/posts/2018-02-04-2018-02-04_Adding-HTTPS-To-GitHub-Pages-Using-A-Custom-Domain-7.jpg)

