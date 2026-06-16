---
title: "Automating Google Form Submission In Ruby"
date: 2020-09-10 18:22:58 +0000
permalink: /automating-google-form-submission-in-ruby-30b0
tags:
  - ruby
  - command-line
  - tutorial
---

Like many children around the country, my kids started school this week.

Due to COVID-19 regulations, my kids' preschool requires that we fill out a form every morning, certifying that our kids haven't developed any COVID symptoms and haven't been exposed to anyone COVID positive.

Being that I have two kids in preschool and my wife teaches there as well, that means filling out the form three times every morning. Something no programmer worth their salt would be willing to do without automating it!

My first instinct was to look if Google Forms had some sort of API for Forms that I could use to write a script, but it turns out that it wasn't even necessary!

Google forms are, at their base, HTML forms. So sending a POST request to the form's URL with the form's data is all you need to do.

The first step you need to do is determine the URL you need to POST to. One way to do it is to open your browser tools to the "Inspect" tab, find the form element, and find the `action` attribute.

For Google Forms, however, that isn't necessary! All you need is the URL of the form you are filling out.

Google Form URLs are of the format `https://docs.google.com/forms/d/e/[a-long-form-ID]/viewform`. 

The URL you need to submit the form to is the same, except you need to change the `/viewform` at the end to `/formResponse` (Really, Google? You couldn't name them consistently? Either both lowercase or both camelCase?) so the final URL should look like this: `https://docs.google.com/forms/d/e/[a-long-form-ID]/formResponse`.

Next, you will need a list of the form's inputs and your responses.

Here Google obfuscates a bit.

Every HTML form is made up of inputs; each input has a `name` attribute, and when the form is submitted, those inputs get submitted in the format `[input-name]=[value]`. The `name` attribute is usually something descriptive, like "age", "date-of-birth", etc. but Google gives each input an ID and uses *that* as the `name` attribute, so it looks more like:
```html
<input name="entry.[input-id]" value="">
```

You *could* go through the form and collect the input IDs one by one to figure out what each one stands for, but I took a short cut.

In the "Inspect" tab of your dev tools, find the `form` element for the form and edit the `action` attribute so it's set to a random string like this:
```html
<form action="xxxxxx">
```
This way, the form won't submit to your school when you hit "Submit" in a moment.

Next, fill out the form the way you usually would with all of the correct answers.

Next, head over to the "Network" tab in your browser's dev tools. Once you're there, hit "Submit" on your form. You should see several requests show up in your browser tools. You're looking for the one that failed and got a 400 status (if you didn't edit the form's action in the previous step then it will not have failed, in which case you're looking for the one that was a POST request and says "formResponse" under "domain").

![screenshot of the Network tab in the dev tools showing the above](/assets/images/posts/2020-09-10-automating-google-form-submission-in-ruby-30b0-433c46.png)

If you click on the request, you should see information about the request populate on the tab's right side. Click on the "Request" tab, and you should see a bunch of key/value pairs representing the form's inputs and the values you entered. Right-click and chose "Copy All" and paste it into a text file.

Here's what I got when I did that:
```json
{
    "entry.1634501314":"child+name",
    "entry.1876184383":"parent+name",
    "entry.338135299":"Toddlers Class",
    "entry.464151171":"No",
    "entry.1301996500":"None+of+the+Above",
    "entry.46633140":"None+of+the+Above",
    "entry.693698665":"Yes",
    "entry.227426312":"No",
    "entry.1433839005":"No",
    "entry.338135299_sentinel":"",
    "entry.464151171_sentinel":"",
    "entry.1301996500_sentinel":"",
    "entry.46633140_sentinel":"",
    "entry.693698665_sentinel":"",
    "entry.227426312_sentinel":"",
    "entry.1433839005_sentinel":"",
    "fvv":"1",
    "draftResponse":"[null,null,\"1394368204515955404\"]\r\n",
    "pageHistory":"0",
    "fbzx":"1394368204515955404"
}
```

We can clean that up a bit by getting rid of all of the entries ending with `_sentinel` (they're an artifact of how Google Forms represent checkboxes and radio buttons) as well as the few fields at the bottom (I'm not sure what they do, but I confirmed that the form works without them).

We also want to convert this JSON object to a Ruby hash, which I did by find/replacing all of the "`:`"s with hash rockets "`=>`".

One last thing you'll want to do is replace all the "`+`" signs that were put instead of the whitespaces (e.g. `"entry.1301996500":"None+of+the+Above"`) and change them back to spaces.

My final form data looks like this now:
```ruby
    form_data = {
        "entry.338135299" => "Toddlers Class",
        "entry.1634501314" => "[child name]",
        "entry.1876184383" => "[parent name]",
        "entry.464151171" => "No",
        "entry.1301996500" => "None of the Above",
        "entry.46633140" => "None of the Above",
        "entry.693698665" => "Yes",
        "entry.227426312" => "No",
        "entry.1433839005" => "No"
    }
```
You can take that information and past it into a file called `school-form-submitter.rb`.

**Note:** If you would just like to see the finished code it will be shared at the end of this post.

If you only need to submit the form for one child, then that's all you need. If you have more than one child like me, you will have to add in the information you need dynamically.

In my case, the parts of the form that had to change for each child were the child's name and class ("Toddler Class" in the form above). So I extracted that information into a hash I called `names`:
```ruby
names = {
	"Child 1 Name" => "Child 1 Class",
	"Child 2 Name" => "Child 2 Class",
	"Wife's Name" => "Staff"
}
```

Then I iterated over the hash and filled out the form like this:
```ruby
names.each do |name, age|
    form_data = {
        "entry.338135299" => age,
        "entry.1634501314" => name,
        "entry.1876184383" => "Parent Name",
        "entry.464151171" => "No",
        "entry.1301996500" => "None of the Above",
        "entry.46633140" => "None of the Above",
        "entry.693698665" => "Yes",
        "entry.227426312" => "No",
        "entry.1433839005" => "No"
    }
    puts "Submitting form for #{name} in #{age}"
end
```

If you run the ruby file now, you should get a series of lines printed that look like:
```bash
Submitting form for Child 1 Name in Child 1 Class
Submitting form for Child 2 Name in Child 2 Class
Submitting form for Wife's Name in Staff
```

The only thing left to do now is to make our POST request.

Being that we are not trying to do anything too complicated with the returned data, I believe Ruby's built-in `Net::HTTP` library should be enough.

Add the following to the top of your file:
```ruby
require 'net/http'
```

We're going to use `Net::HTTP`'s `post_form` method. The method takes two arguments: a `URI` object and a hash of form inputs. So let's convert the URL we got earlier to a `URI` object like this:
```ruby
form_url = URI("https://docs.google.com/forms/d/e/[a-long-form-ID]/formResponse")
```

We can then submit our form (and print the return status message as a sanity check) like this:
```ruby
res = Net::HTTP.post_form form_url, form_data
puts "Status #{res.message}"
```

And there you have it! Instead of tediously filling out forms every morning, you can submit them by running `ruby school-form-submitter.rb` from your console, and all it took was around 25 lines of code!

Here is the complete code:

<script src="https://gist.github.com/achasveachas/eb25a97d7d88cd8b883a4763aaeae508.js"></script>
<noscript><a href="https://gist.github.com/achasveachas/eb25a97d7d88cd8b883a4763aaeae508">View gist</a></noscript>