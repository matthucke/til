# Symbol as Proc

Most Rubyists soon discover that methods that take a block can be passed a symbol, using the "&" operator, which converts a symbol to a Proc.  I've been using this trick for a few years, to save typing.

```ruby
things.map(&:name) # same as things.map { |foo| foo.name }
things.sort_by(&:priority) #  same as things.sort_by { |foo| foo.priority }
```

# Expression returning symbol, as Proc

At first I'd thought "&:" was an operator - but it's not.  "&" is an operator, and the colon is just part of the symbol.  This is easily proven by putting some space between those characters:

```ruby
things.map(&        :name)
```

...and that of course means that any expression can take the place of the symbol:

```ruby
things.sort_by(& my_sort_field)		# OK if my_sort_field is a symbol
things.sort_by(& "priority") 				# FAIL - no Strings allowed here!
things.sort_by(& "priority".to_sym)	#  to_sym takes the curse off it.

# or something dynamic from the interweb...
# (obviously you'd sanitize this input against a whitelist in real life)
things.sort_by(& params.fetch(:sort_order, 'priority').to_sym )

sort_field = :name
things.sort_by(&sort_field).map(&sort_field)  # chaining them, too
```

So, there you have it - any expression returning a symbol (not a String) is fair game for passing to the "&" operator and then to a function wanting a block.
