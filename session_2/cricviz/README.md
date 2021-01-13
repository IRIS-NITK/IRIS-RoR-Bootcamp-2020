# Working with Records | Cricviz

A _record_ is a unique row of a database table. SQL restricts our
operations on a row:
- Creating a record
- Reading a record
- Updating a record
- Deleting a record.

The four operations are commonly referred with the acronym *CRUD*. Any
change to the data stored must be made up of these operations. Each of
the operations map to a different SQL statement and Rails construct.

Rails breaks down the _Reading_, _Updating_ and _Deleting_ a record
into two steps:
- Querying the records to be operated upon.
- Carrying out the actual operation.

Thus, the three operations are similar to each other.

> Read through [Active Record Basics](https://guides.rubyonrails.org/active_record_basics.html#crud-reading-and-writing-data)
> for a brief introduction to working with models in Rails.

We will be working with some statisitcs from the world of Cricket, and
hope to crack the problem of winning the fourth test match in
Border-Gavaskar series!

## Steps

- [Prepare Local Database](/session_2/README.md) in the `cricviz`
  folder.

The schema file (`db/schema.rb`) should show:

```ruby
ActiveRecord::Schema.define(version: 2021_01_11_113441) do
  create_table "cricketers", force: :cascade do |t|
    t.string "name"
    t.string "country"
    t.string "role"
    t.integer "matches"
    t.integer "innings_batted", default: 0
    t.integer "runs_scored", default: 0
    t.integer "not_out", default: 0
    t.integer "high_score", default: 0
    t.integer "balls_faced", default: 0
    t.integer "centuries", default: 0
    t.integer "half_centuries", default: 0
    t.integer "sixes_scored", default: 0
    t.integer "fours_scored", default: 0
    t.integer "innings_bowled", default: 0
    t.integer "balls_bowled", default: 0
    t.integer "runs_given", default: 0
    t.integer "wickets_taken", default: 0
    t.string "best_bowling_innings", default: "-"
    t.string "best_bowling_match", default: "-"
    t.integer "catches", default: 0
    t.integer "stumpings", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end
end
```

The schema indicates that we have one table `cricketers` with many, many
columns - each indicating a different stats associated with the player.
The column names will be the attributes that we can use in our class.

- [Load the sample data](https://brandonhilkert.com/blog/using-rails-fixtures-to-seed-a-database/)

```bash
rails db:fixtures:load
```

_Fixtures_ is a fancy word for sample data. The above command loads
sample data into our development database for trying out our code. You
can check out fixtures through rails console.

### Creating Records

The `INSERT INTO` statement is used to insert new records in a table.
For example:

```sql
INSERT INTO employees 
(employee_number, name, address, title, phone_number, salary) VALUES
(1, 'Abhishek Kumar', 'Patna', 'Web Manager', '0000000000', 1000.0);
```

The Rails equivalent would be:

```ruby
Employee.create(
  employee_number: 1,
  name: 'Abhishek Kumar',
  address: 'Patna',
  title: 'Web Manager',
  phone_number: '0000000000',
  salary: 1000.0
)
```

Implement the function `import_classical_batters` in
`app/models/cricketer.rb` with the following players:

| Name | Country | Role | Matches | Innings | Not Outs | Runs | Balls Faced | High Score | Centuries | Half-Centuries |
| ---  | ---     | ---  | ---     | ---     | ---      | ---  | ---         | ---        | ---       | ---            |
| Sachin Tendulkar | India | Batter | 200 | 329 | 33 | 15921 | - | 248 | 51 | 68 |
| Rahul Dravid     | India | Batter | 164 | 286 | 32 | 13288 | 31258 | 270 | 36 | 63 |
| Kumar Sangakkara | Sri Lanka | Wicketkeeper | 134 | 233 | 17 | 12400 | 22882 | 319 | 38 | 52 |
| Ricky Ponting    | Australia | Batter | 168 | 287 | 29 | 13378 | 22782 | 257 | 41 | 62 |
| Brian Lara       | West Indies | Batter | 131 | 232 | 6 | 11953 | 19753 | 400 | 34 | 48 |

- [Insert Into SQL Statement](https://www.w3schools.com/sql/sql_insert.asp)
- [Create | Active Record Basics](https://guides.rubyonrails.org/active_record_basics.html#create)

### Selecting Records

The `SELECT` statement is used to select data from a database. For
example:

```sql
SELECT * FROM employees; 
```

This above statement selects all columns from the employee table. We
also can specify conditions like:

```sql
SELECT * FROM employees WHERE name == 'Abhishek Kumar';
```

The above statement selects all columns of employees named 'Abhishek
Kumar'.

There are many differents ways to select records in Rails with:
- `all`: Select all records.
- `where`: Selects all records satisfying given conditions.
- `find_by`: Selects the _first_ record fullfilling conditions.
- `first`, `second`, `third`, ..., `last`: Selects the nth record.

Let's see how each of them work:

```ruby
# Select all employees
Employee.all

# Selects all employees working in HR 
Employee.where(role: 'HR') 

# Selects all employees who work in HR and live in Mangalore.
Employee.where(role: 'HR', address: 'Mangalore')

# Selects first employee
Employee.first

# Selects first employee in HR
Employee.find_by(role: 'HR')

# Selects last employee
Employee.last
```

Each of the above commands return an `ActiveRecord::Relation` object,
which can be iterated as an ordinary array. Operations like iterating
over the array, filterring elements and mapping the elements to a new
value are all possible. For example:

```ruby
Employee.all.each do |employee|
  employee.generate_performance_report # Just like an item in array
end
```

You can also the sort results by the values stored in columns as:

```sql
# Select all employees, sort by alphabetic order of names
SELECT * FROM employees ORDER BY name ASC;
```

```ruby
Employee.all.order(name: asc)
```

_Scopes_ allow you to specify commonly-used queries and mix-and-match as
you go. Imagine searching for managers and people who earn more than
10,000 frequently. You write them more briefly as:

```ruby
scope :managers, -> { where(role: 'Manager') }
scope :with_salary_more_than, ->(x) { where('salary > ?', x) }

# Shorter and easier to understand
Employee.managers
Employee.with_salary_more_than(10000)
```

Implement the scopes `australian_players`, `batters`, `bowlers` and
`descending_by_matches` in `app/models/cricketer.rb`.

- [Select SQL Statement](https://www.w3schools.com/sql/sql_select.asp)
- [Read | Active Record Basics](https://guides.rubyonrails.org/active_record_basics.html#read)
- [Active Record Query Interface](https://guides.rubyonrails.org/active_record_querying.html)
- [SQL Order by Keyword](https://www.w3schools.com/sql/sql_orderby.asp)
- [How to Use Scopes in Ruby on Rails](https://www.rubyguides.com/2019/10/scopes-in-ruby-on-rails/)

### Updating Records

The `UPDATE` statement is used to modify the existing records in a
table.

```sql
UPDATE employees
SET title = 'Fired'
WHERE name = 'Abhishek Kumar'
```

The Rails equivalent would be:

```ruby
# Using Active Record Objects
user = User.find_by(name: 'Abhishek Kumar')
user.title = 'Fired'
user.save

# Shorter but less flexible
User.where(name: 'Abhishek Kumar').update(title: 'Fired')
```

Otherwise, updating records is the same as creating them - so that's easy!

Implement the function `update_innings` in `app/models/cricketer.rb`

- [SQL UPDATE Statement](https://www.w3schools.com/sql/sql_update.asp)
- [Update | Active Record Basics](https://guides.rubyonrails.org/active_record_basics.html#update)

### Deleting Records

The `DELETE` statement is used to delete existing records in a table.

```sql
DELETE FROM employee WHERE title = 'Fired';
```

The Rails equivalent:

```ruby
Employee.where(title: 'Fired').delete
```

Implement the function `ban` in `app/models/cricketer.rb`.

---

That's all about the working with records - it's a lengthy and important
topic, forming the core of *backend* development.

Once you start implementing functions in `app/models/cricketer.rb`, you
can check if your code is correct by executing against the test suite.

```ruby
rails test:models
```
