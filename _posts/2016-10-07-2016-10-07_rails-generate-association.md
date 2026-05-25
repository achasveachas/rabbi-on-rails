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

* * *

### rails generate association

The other day I stumbled upon a cool feature in Rails, entirely by accident. Being that I didn’t see it discussed much I figured I’d share it here.

For the sake of those less familiar with the concepts, I will start off with explaining what “associations” are in Rails. You may find this part boring; if you are already familiar with it, feel free to skip down to the section entitled “ **Get to the Point** ”.

#### belongs\_to and&nbsp;has\_many

To start with, we need to understand what associations are in Rails and how they work.

Say I build an app that tracks what snacks my cats like. My app needs to keep track of 2 concepts here, cats and snacks.

![](/assets/images/posts/2016-10-07-2016-10-07_rails-generate-association-0.jpeg)

_Or cats that are snacks…_
{: .image-caption}

So my app has a `Cat` Model and a `Snack` Model, but keeping track of just cats and snacks is not very useful to me, I want to know WHICH snacks WHICH cat likes. So in addition to keeping track of my cats and snacks, my app also has to keep track of the connections between specific cats and specific snacks.

In Rails we call these connections “Associations”, and these associations come in 2 flavors:

On the one hand, each snack has to be associated with a cat, I have to be able to ask the snack “which cat do you belong to?” and the snack has to be able to answer “I belong to cat X”. In rails, this is called a “belongs\_to” association, where every Snack `belongs_to` a Cat.

![](/assets/images/posts/2016-10-07-2016-10-07_rails-generate-association-1.jpeg)

Then we have the other side of the association, where each Cat owns all its snacks, so that if you ask a Cat “which snacks are yours?” it will be able to answer “Snack X,Y, and Z are mine”. This kind of association is called a “has\_many” association, where each Cat `has_many` Snacks.

![](/assets/images/posts/2016-10-07-2016-10-07_rails-generate-association-2.jpeg)

So to summarize, we have a 2-way association here where every Cat `has_many` Snacks and every snack `belongs_to` a Cat.

#### Foreign Keys

How does my app keep track of these associations? Simple. Every Cat in my app has a unique ID, all I have to do now is set up my Snack models in such a way that they have a property called `cat_id`, so when I ask the Snack “which Cat do you belong to?” all it has to do is look up its `cat_id` and say “I belong to Cat number 42”. Similarly, if I ask a Cat “which snacks do you like?” all the Cat has to do is look through the Snack list and find all of the Snacks that have its ID in their `cat_id` column.

#### Show me the&nbsp;code

Until now I’ve been speaking pretty high level. Let’s get down to the nitty-gritty code for a bit.

Here’s what our Cat model will look like:

```ruby
class Cat < ApplicationRecord
  has_many :snacks
end
```

And here’s what our Snack model will look like:

```ruby
class Snack < ApplicationRecord
  belongs_to :cat
end
```

Now in order for these Snacks and Cats to persist, we need to add them to a database with a `cats` table and a `snacks` table.

The way we do that in Rails is by setting up the following 2 ActiveRecord migrations:

```ruby
class CreateCats < ActiveRecord::Migration
  def change
    create_table :cats do |t|
      t.string :name
    end
  end
end
```

```ruby
class CreateSnacks < ActiveRecord::Migration
  def change
    create_table :snacks do |t|
      t.string :name
      t.integer :cat_id
    end
  end
end
```

You’ll notice that both the `cats` table and the `snacks` table have a column for the `name` that accepts a string, and then the `snacks` table has another column `cat_id` that accepts an integer for the ID of the Cat the Snack `belongs_to`.

Of course, thanks to Rails Generators I didn’t have to type all of that out by hand, I was able to use Rails’ Model Generator to generate the Models and the Migrations using the commands `rails generate model Cat name:string` and `rails generate model Snack name:string cat_id:integer`. That generated the basic models and migrations, all I had to fill out was the `has_many` and `belongs_to` associations in the models.

#### Get to the&nbsp;Point

All of the above is pretty basic Rails, here’s the feature I discovered:

The other day I was pursuing a lesson on [Learn.co,](http://learn.co/with/achasveachas) the lesson was discussing a basic blog app where users can comment on posts. In this app, every comment `belongs_to` a User and a Post. The lab had snippets showing the code for the Models and Migrations, usually I would just skim over them and get to the actual lesson, this time however, something caught my eye:

```ruby
class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :content
      t.belongs_to :user
      t.belongs_to :post
      t.timestamps null: false
    end
  end
end
```

Wait a minute; I knew that `string` was a valid datatype for an attribute, and I knew `timestamps` was a valid datatype (it creates a date/time stamp when a new comment is created and another one every time it’s updated), but what’s a `belongs_to` datatype? Could it be that instead of having to put in a `user_id` I could just make a table column `t.belongs_to`?

I tried it out, I changed my Snacks database to the following:

```ruby
class CreateSnacks < ActiveRecord::Migration[5.0]
  def change
    create_table :snacks do |t|
      t.string :name
      t.belongs_to :cat
    end
  end
end
```

I ran the migration and lo and behold! My Snacks knew which Cat they belonged to! Apparently putting a `belongs_to` column into your migration with a model name as an argument adds a column `[model_name]_id`.

#### But will it Generate?

The next step was to see if I can use that with Rails’ Generators. So I ran `rails generate model Snack name:string cat:belongs_to` and sure enough when I checked the resulting migration this is what I found:

```ruby
class CreateSnacks < ActiveRecord::Migration[5.0]
  def change
    create_table :snacks do |t|
      t.string :name
      t.belongs_to :cat, foreign_key: true
      t.timestamps
    end
  end
end
```

The `belongs_to` column was right there.

But that’s not all. When I took a look at the actual Model that was generated I found a surprise there too:

```ruby
class Snack < ApplicationRecord
  belongs_to :cat
end
```

The `belongs_to` association was right there without me putting it in manually! When I generated a `belongs_to` attribute in my Snack migration Rails figured out that my Snack would belong to a Cat and put in that association there for me.

#### Reverse order?

Naturally, I was now curious to see if it would work in the reverse, could Rails generate a `has_many` association?

I ran `rails generate model Cat name:string snacks:has_many`. No luck.

the migration did have a `has_many` column:

```ruby
class CreateCats < ActiveRecord::Migration[5.0]
  def change
    create_table :cats do |t|
      t.string :name
      t.has_many :snacks
      t.timestamps
    end
  end
end
```

but as far as I can tell that column is meaningless.

The model looked like:

```ruby
class Cat < ApplicationRecord
end
```

No automatic `has_many` association there either.

I was pretty pumped at having discovered all this. I started searching around sure I would find it being discussed, I didn’t find much about it out there, and definitely nothing on the fact that the association can be generated using standard Rails generators. I figured that would be strange, but I’m sure I’m not the only one who would be interested, so I hope this post can help someone else out there.

Happy Coding!

