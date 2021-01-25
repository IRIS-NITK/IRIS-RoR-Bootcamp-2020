# Session 5 - Associations, Validations

After learning about MVC architecture and implementing different layers
in Rails code, we will take a look at some of useful concepts in
practical web development - _associations_ and _validations_.

An _association_ refers to the connection between two Active Record
model. Using associations makes common operations simpler and easier.

_Validating_ data is an important part of designing applications.
Missing, incomplete or incorrect user data often leads to bugs that are
difficult to fix. If a user can possibly screw something, they will.

## Pre-requistes

- [Install Ruby and Rails](/installation.md)

- [Set Up Local Workplace](/essential_git.md)

- [Implement Blogspot](/session_4/README.md)

## Associations

In a relational database, we store information as a set of tables with
rows (_records_) and columns (_attributes_).

If we can uniquely identify a row using values stored in a group of
columns, we call the group _primary key_. 

For example: In a `users` table, we can uniquely identify each row by
the e-mail of the user but not the name as two people might have same
name.

By default, Rails generates an integer column `id` which automatically
increments with each new record added and is used as the primary key.

Often, we want to link (_associate_) two tables together as we did in 
the session_3 - linking the `users` table and `articles` table with the
column `user_id` in the `articles` table, denoting the author of the
article.

A _foreign key_ is a column that matches a primary key in a different
table. Thus, the column `user_id` in `articles` table is a foreign key.

> Note: Rails do not automatically generate the foreign key, so make
> sure to add them in a migration.

- [What Is a Primary Key?](https://www.lifewire.com/primary-key-definition-1019179)
- [SQL - Foreign Key - TutorialsPoint](https://www.tutorialspoint.com/sql/sql-foreign-key.htm)

## Types of Associations

Rails supports six types of associations (_linkages_), each appropriate
to different use case:
- Belongs to
- Has one
- Has many
- Has many through
- Has one through
- has and belongs to many

We will talk about Belongs to, Has one and Has many association types as
the other three types are similar modifications.

### Belongs To

A `belongs_to` association indicates the model cannot exist without the
other model. In our blogging application, an article cannot exist
without an user, so a `belongs_to` association is appropriate.

```ruby
class Article < ApplicationRecord
  belongs_to :user
end
```

### Has One

A `has_one` association indicates the model "has one" instance of the
other model. For example: If we store profile photos, each user "has
one" profile photo.

```ruby
class User < ApplicationRecord
  has_one :profile_photo
end
```

### Has Many

A `has_many` association indicates the model "has many" instances of the
other model. For example: an user "has many" articles that they have
authored.

```ruby
class User < ApplicationRecord
  has_many :articles
end
```

- [Database Relationships](https://condor.depaul.edu/gandrus/240IT/accesspages/relationships.htm)

### Helper Methods

After defining associations, we gain many useful functions as:

```ruby
# Same as ProfilePhoto.find_by(user_id: user.id)
user.profile_photo

# Same as Articles.where(user_id: user.id)
user.articles

# Same as Article.create(user_id: user.id, published_at: Time.now)
user.articles.create(published_at: Time.now)

# Deletes the user *and* their profile photo
user.destroy
```

- [Active Record Associations - Ruby on Rails Guides](https://guides.rubyonrails.org/association_basics.html#belongs-to-association-reference)
- [Relationships - Jumpstart Lab Curriculum](http://tutorials.jumpstartlab.com/topics/models/relationships.html)

## Validations

Validations ensure only "valid" data is saved into the database. For
example: we have to ensure that users provide a valid e-mail address, so
that "reset password" emails are delivered correctly.

There are several ways to provide validations, at different levels of
the application:
- Database constraints (database-level validation)
- Active Record validations (model-level validation)
- Controller-level validations
- Client-side validations using Javascript (view-level validation)

In general, use both model-level validation and view-level validation as
client side validation is unreliable but provides immediate feedback.

- [Why Use Validations](https://guides.rubyonrails.org/active_record_validations.html#why-use-validations-questionmark)

### Popular Validations

We will discuss the more popular and commonly used validations. You can
check out the full API here: [Validation Helpers](https://guides.rubyonrails.org/active_record_validations.html#validation-helpers)

- Presence: check if the attribute is not empty.

```ruby
class Article < ApplicationRecord
  validates :title, presence: true
end
```

- Numericality: validates numeric properties. Has additional options
  `only_integer`, `greater_than`, `less_than` and others.

```ruby
class Student < ApplicationRecord
  # CGPA must be decimal number between 0 and 10 (inclusive).
  validates :cgpa, numericality: {
    greater_than_or_equal_to: 0.0,
    less_than_or_equal_to: 10.0
  }
end
```

- Length: validates the length of attribute in different ways with
  options `minimum`, `maximum`, `within` and others.

```ruby
class User < ApplicationRecord
  # Phone number can be between 10 digits and 12 digits
  # (including country code)
  validates :phone_number, length: {
    minimum: 10,
    maximum: 12
  }
end
```

- Format: validates whether the attribute matches a [regular expression](https://www.rubyguides.com/2015/06/ruby-regex/)

```ruby
class User < ApplicationRecord
  validates :name, format: {
    with: /\A[a-zA-Z ]+\z/,
    message: "only allows letters and spaces"
  }
```

- Uniqueness: validates whether the attribute is unique for the model.

```ruby
class User < ApplicationRecord
  validates :email, uniqueness: true
end
```

You can also create custom methods to validate the models.

```ruby
class Invoice < ApplicationRecord
  validate :expiration_date_cannot_be_in_past

  def expiration_date_cannot_be_in_past
    if expiration_date.present? && expiration_date < Date.today
      errors.add(:expiration_date, "can't be in past")
    end
  end
end
```

### Save vs Save!

The validations are executed when we try to save (or update) the
database record.

The functions ending with `!` (`save!`, `update!` and others) are called
_unsafe functions_ and raise an exception if the record is not valid.

On the other hand, functions not ending with `!` are called _safe
functions_ and return true/false depending whether the record is valid.
Thus, you must use the return value for control flow like `create`
action:

```ruby
class UsersController < ApplicationController
  def create
    if @user.save
      flash[:notice] = 'Your account has been created'
    else
     flash[:alert] = 'Unable to create your account'
    end

    redirect_to users_path
  end
end
```

### Displaying Errors

We can check whether a record is valid or not using `valid?` and
`invalid?` methods:

```ruby
admin = User.new
admin.valid?
```

We find all errors for an record using `errors.full_messages` method:

```ruby
admin.errors.full_messages
```

The errors are displaying the view `_form.html.erb` as:

```erb
<% if @article.errors.any? %>
  <div id="error_explanation">
    <h2>
      <%= pluralize(@article.errors.count,  "error") %> prohibited this
      article from being saved:
    </h2>

    <ul>
      <% @article.errors.each do |error| %>
        <li><%= error.full_message %></li>
        <% end %>
    </ul>
  </div>
<% end %>
```

Which generates a list of errors with the `@article` variable.

- [Active Record Validations](https://guides.rubyonrails.org/active_record_validations.html#custom-methods)
- [Validations - Jumpstart Lab Curriculum](http://tutorials.jumpstartlab.com/topics/models/validations.html)

## Task

Consider the following scenario:

- A student has name, branch, admission year, e-mail and roll number.
- A course has name, course code, branch, year, credits.
- An assignment has name, submission deadline, weightage.
- A student can register for many courses.
- A course can have many students.
- A course has many assignments.
- A student can upload files for assignments for their registered courses.
- The only branches offered are `Computer Science and Engineering`,
  `Mechanical Engineering`, `Mining Engineering` and `Electronics and
  Communication Engineering`.
- The roll numbers follow same format as NITK:
  `#{Last two digits of admission year}#{Branch code}#{Three digit serial number}`.
- A course code follows format: `#{Branch code}#{Three digit course number}`.
- A course can have maximum of six credits.
- An assignment can have a maximum weightage of 50%.
- A student cannot submit assignments after the submission deadline.

To solve the task, follow the below steps:

1. Design the schema for above scenario.

2. Identify associations between different tables.

3. Write migrations.

4. Create database and migrate.

5. Define associations in Active Record models.

6. Define validations in Active Record models.

Once done, create a pull request and describe the schema, associations
and validations in the README file.
