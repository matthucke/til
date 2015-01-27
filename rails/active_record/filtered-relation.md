# Filtering an ActiveRecord relation.

A relationship such as `has_one`, `has_many`, or `belongs_to` usually links up records based on primary keys and foreign keys.

What if another criteria is needed?  Filtering those records after they're loaded is error-prone - better to do it in the query.

In my case, I built a new app to list products on Google Shopping, replacing a legacy app that also published items to Bing, Yahoo and other services.  The product configurations  for those other channels should not be loaded into the new Google-only app.

```ruby
class Product
  has_many :channel_configs # no good
end
```

`Product.channel_configs` would include config objects for Bing, Yahoo, etc., as well as Google - you'd have to do a 'find' or 'select' on that list afterwards every time it's used, to get the one that's relevant.

## Relation with Scope

By placing a lambda as the second argument to has_many (or has_one, which is a better fit for this app, now that I know I'll get just one result per product), one can alter the generated SQL:

```ruby
class Product
  has_one :channel_config, -> { where(channel_name: 'google') }
end
```

## Default Scope

On the ChannelConfig class itself I have the same filtering expression - ensuring that any time a ChannelConfig is loaded, it will be the Google one and not Bing or Yahoo or whatever.

```ruby
class ChannelConfig
  default_scope -> { where(channel_name: 'google') }
end
```

## Testing it.
I could make lots of fixtures for those channels I don't care about and ensure they're not loaded.  Or, just look at the SQL:

```ruby
expect(ChannelConfig.all.to_sql).to match(/channel_name='google'/)
```
...and indeed it does.

## Belt and suspenders.

Technically, putting in the default_scope makes the filtering expression on the has_one redundant - the channel_name='google' appears twice in the generated SQL when loading that record!  But I'm fine with that - it costs the database nothing to see that clause twice, and it provides added assurance that we won't be contaminated by unwanted records.




