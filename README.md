# JsonQL

jql is a small query interface for JSON that supports SELECTs with multiple conditions.

## Use

To use jql add this line to your application's Gemfile:

```ruby
gem 'json_q_l'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install json_q_l

After bundling from the command line call jql and pass a JSON file formatted like this:
```json
{
  "events": [
    {
      "occasion": "Birthday party",
      "invited_count": 120,
      "year": 2015,
      "month": 3,
      "day": 14
    },
    {
      "occasion": "Press release",
      "invited_count": 64,
      "year": 2015,
      "month": 6,
      "day": 7,
      "cancelled": true
    }
  ]
}
```
Where "events" represents a table name and each element of the array a single column.


```
jql events.json
```

Then try executing a command
```
jql~>  SELECT * FROM events WHERE year = 2015 AND occasion = 'Birthday party';
```

Have fun!
