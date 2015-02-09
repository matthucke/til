# Yoda was wrong - there is a "try".

Rails ActiveSupport monkeypatches Ruby's Object and NilClass in many ways - one of these is to add a "try" function.

```ruby
nil.try(:anything) => nil
nil.try { block } => nil

foo.try(:anything) => foo.send(:anything)
foo.try { block } => (yields foo to block)
```

# Is this useful?

Yes.  It lets you avoid the ternary operator - which, though I'm comfortable with it after decades of using it, looks kind of awkward and results in excess typing - especially when the object you're concerned might be null is a property of some other object.

```ruby

# old way
foo ? foo.something : nil
thingy.other_thingy ? thingy.other_thingy.something : nil

# try
foo.try(:something)
thingy.other_thingy.try(:something)

```

# With parameters.

You can pass extra parameters to 'try'.  I find this useful for things like 'strftime'; in my view templates, I don't want to have to constantly be checking that date fields actually have a value before trying to work with it:

```ruby
# old way
order.shipped_at ? order.shipped_at.strftime("%b %d %Y") : "not shipped"

# with try
order.shipped_at.try(:strftime, "%b %d %Y") || "not shipped"
```

## also, Monadic
The **monadic** gem, which I'd already been using, provides similar functionality by using a Maybe function that returns one of two clases - `Just` or `Nothing`.  You can chain any method names after a Maybe, and then use "._(default value)" at the end to bring it back to a real value:

```ruby
Maybe(nil) => Nothing
Maybe(nil).strftime("%Y-%m-%d") => Nothing
Maybe(nil).strftime("%Y-%m-%d")._ => "Nothing"
Maybe(nil).strftime("%Y-%m-%d")._("not shipped") => "not shipped"

Maybe(Date.today) => Just #  (with @value = Date instance)
Maybe(Date.today).strftime("%Y-%m-%d") => Just # (with @value = String instance)
Maybe(Date.today).strftime("%Y-%m-%d")._ => "2015-02-09"
Maybe(Date.today).strftime("%Y-%m-%d")._("not shipped")=> "2015-02-09"

```

