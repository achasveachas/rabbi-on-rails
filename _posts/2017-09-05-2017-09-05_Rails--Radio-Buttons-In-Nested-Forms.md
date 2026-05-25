---
title: "Rails: Radio Buttons In Nested Forms"
date: 2017-09-05 00:20:13 +0000
permalink: /rails-radio-tags-in-nested-forms-4f252ae8cf53
header:
  teaser: /assets/images/posts/2017-09-05-2017-09-05_Rails--Radio-Buttons-In-Nested-Forms-0.png
categories:
  - 
---

* * *

### Rails: Radio Buttons In Nested&nbsp;Forms

#### The story behind my first Stack Overflow&nbsp;answer.

I was recently asked to add a feature to a Rails app. The app is a Contact Management System (CMS). Each contact has a name, an email address, and a phone number. I was asked to add the ability for multiple phone numbers to be added to each contact; each phone number should be either a home number, work number, or cell-phone number. Also, one of the numbers should be designated the default number.

The way I approached it was by moving the phone numbers into a separate `PhoneNumber` class, with a many-to-one relationship to the `Contact` class, so now every contact could have many phone numbers, and every phone number belongs to a contact (for more on one-to-many associations in Rails see my blog-post [rails generate associations](https://blog.yechiel.me/generating-belongs-to-associations-in-rails-be7b7fdea96c)).

I now had to update the ‘New Contact’ form to accept the nested attributes for the `PhoneNumber` class, as well as add a radio button so users can select which number would be the default, and this is where I ran into a problem.

#### No soap,&nbsp;radio!

First a brief explanation of how radio buttons work:

If you look at the HTML for a form with radio buttons, you will see that each button is it’s own input element, what links them together is that they all share the same `name` attribute. This is what it looks like:

IFRAME\_PLACEHOLDER\_TOKEN\_0

Notice how each `input` has the same name (`picker`), that’s what lets the browser know that they are all linked and that it should only allow one of the buttons to be picked at a time.

#### Rails Helpers

Rails has a built in helper method that generates radio buttons for forms; the `radio_button` method. When that method is called on a form element Rails will automatically generate the proper HTML element with the correct attributes so that when the form gets submitted your server will know how to construct a new object (or update an existing one) from the data.

My problem was that I wasn’t making a regular form, I was making a nested form, a form within a form. I had my Contact form, and within the Contact form, I was collecting attributes for my `PhoneNumber` class.

Rails generally handles that kind of stuff pretty well. What it does is, it adds fields to your form, and each field gets a name attribute that follows the format of `parent_class[nested_classes_attributes][:index][attribute]`, so in my case, where I had `PhoneNumber` nested in the `Contact` parent class, the Number field in the first phone number form had a name attribute of `contact[phone_numbers_attributes][0][number]`, the number field in the second phone number form had a `name` attribute of `contact[phone_numbers_attributes][1][number]`, and so on. Each form incrementing the index by one, so that the server would know we are dealing with different `PhoneNumber` objects.

The problem was that I needed a radio button on each phone number form so that users could choose which phone number was the default, but I needed all of the radio buttons to have the same name. The Rails form helper method, as mentioned, was treating each phone number as a separate form, and giving each button a different name attribute.

As usual, I turned to Google and was pretty excited to see that one of the first results linked to a question on Stack Overflow that sounded just like the problem I was having. The problem was that when I clicked on it, I saw that even though the question was first asked in 2011, it only had three answers, and none of them solved my problem.

![](/assets/images/posts/2017-09-05-2017-09-05_Rails--Radio-Buttons-In-Nested-Forms-0.png)

_Image Credit: XKCD_
{: .image-caption}

#### Great Help!

An incomplete solution provided by one of the answers was that, instead of attaching the radio button to the existing form, to have it as an independent `radio_button_tag` and to manually supply the name as well as any other attributes needed. That would result in a form that looked like this:

```erb
<%= form_for @contact do |f| %>
<%= f.text_field :name %>
<%= f.email_field :email %>
<%= f.fields_for :phoneNumbers do |phone_form| %>
<%= phone_form.text_field :number %>
<%= phone_form.select :location, ["Home", "Work", "Mobile", "Fax"] %>
<%= radio_button_tag "contact[default_telephone]" %>
<% end %>
<% end %>
```

You will notice that the&nbsp;`:number` and&nbsp;`:location`fields are attached to a `phone_form` object which gives them their `name` attribute, but the radio button tag isn’t attached to anything, instead the name (`contact[default_telephone]`) is supplied as an argument.

The problem is that the radio buttons need two more pieces of information to work properly. The first piece of information was the value that would be submitted if the button was checked off, which would ideally be the index of the current phone number the form was rendering. The second piece of information was which phone number was the current default number so that the correct button would be selected by default if the form was an Edit Contact form. And those two pieces of information were missing from the Stack Overflow answer; I was on my own.

#### A Solution To Every&nbsp;Problem

I spent some time thinking about the problem and realized something. The other fields, the ones that were attached to `phone_form` were probably getting their information from the `phone_form` object. If my `radio_button_tag` was still within the `phone_form` scope (which it was, as long as I put it before the first `<% end %>` tag) it should have access to the `phone_form` object and any methods available to it.

I would have to find a way to inspect the `phone_form` object and see what was available through it.

One of my favorite debugging methods in rails is to put a `raise <object>.inspect` at a spot in my code, then when my app would reach that breakpoint it would display the object on the screen as an error, along with a console that would have access to any variables available at the breakpoint.

The problem was, I have only used that method in my controllers, I never used it in a view yet, and while I had a hunch it would work, I wanted to make sure. So to start with I put the following in the middle of my view:  
`<% raise "Hello World".inspect %>` and navigated to that page. Sure enough, I got the following screen:

![](/assets/images/posts/2017-09-05-2017-09-05_Rails--Radio-Buttons-In-Nested-Forms-1.png)

_Notice the “Hello World” near the top._
{: .image-caption}

Perfect, now let’s inspect the actual object. I put the following into my form, right before the radio button tag `<% raise phone_form.inspect %>`:

![](/assets/images/posts/2017-09-05-2017-09-05_Rails--Radio-Buttons-In-Nested-Forms-2.png)

_A wall of text if there ever was one…_
{: .image-caption}

Yeah, quite an eyeful. That’s what a Ruby Object looks like, and this object was apparently a `FormBuilder `object. All the information I needed was somewhere in the huge wall of text; the problem was how to find it.

I headed to the console at the bottom to see what I could find. Running `phone_form` just gave me the same wall of text, so I decided to run `phone_form.methods` to see what methods were available to the `phone_form` object.

I actually ran `phone_form.methods-Object.methods` to remove any methods that were generic to all Ruby objects and got:

```irb
>> phone_form.methods - Object.methods
```

```irb
=> [:select, :index, :options, :label, :options=, :object, :multipart?, :submit, :object=, :fields, :to_partial_path, :to_model, :multipart, :date_select, :object_name, :time_select, :datetime_select, :fields_for, :text_field, :password_field, :hidden_field, :file_field, :text_area, :check_box, :radio_button, :color_field, :search_field, :telephone_field, :phone_field, :date_field, :time_field, :datetime_field, :datetime_local_field, :month_field, :week_field, :url_field, :email_field, :number_field, :range_field, :field_helpers, :field_helpers=, :multipart=, :button, :emitted_hidden_id?, :field_helpers?, :object_name=, :collection_select, :grouped_collection_select, :time_zone_select, :collection_radio_buttons, :collection_check_boxes, :model_name_from_record_or_class, :convert_to_model]
```

Playing around with some of the more promising sounding method names, I found the the&nbsp;`:index` method did indeed give me the index of the current form, and&nbsp;`:object` gave me the object that was tied to the form, so my final radio tag ended up looking like this:

```erb
<%= radio_button_tag "contact[default_telephone]", phone_form.index, phone_form.object.default %>
```

The first argument (`"contact[default_telephone]"`) is the `name` attribute, which is the same for all phone number forms and ensures my radio buttons would act like radio buttons.

The second argument (`phone_form.index`) is the value passed in by the radio button, and is equal to the index of the form currently being worked on, and will be used by the controller to identify which phone number is the default one (as I will show soon).

The third argument (`phone_form.object.default`) determines whether the radio button should be selected by default. `phone_form.object` is the current `PhoneNumber` object the form is rendering, and the&nbsp;`.default` is the current value of whether this instance of `PhoneNumber` is default or not.

Now I just had to update my controller to let it use the information passed in by my form. I added the following two lines of code to the beginning of my `create` and `update` controllers:

```ruby
def create
  default_index = params[:contact][:default_telephone]
  params[:contact][:telephones_attributes][default_index][:default] = true
  # Create the new object....
end
```

#### Share The&nbsp;Love

There was just one thing left to do. I remembered what it was like to find that Stack Overflow question without a proper answer, I realized I would probably not be the last person to ask that question, so I headed back the question and added my very [first Stack Overflow answer!](https://stackoverflow.com/a/46029423/6298150)

![](/assets/images/posts/2017-09-05-2017-09-05_Rails--Radio-Buttons-In-Nested-Forms-3.gif)

>

As a code newbie, I have spent countless hours reading questions and answers on Stack Overflow. Stack Overflow has been my buddy, mentor, and big brother. Being able to give back and contribute was a huge milestone. Hopefully, that answer will be the first of many.

