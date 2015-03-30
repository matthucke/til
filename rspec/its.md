# Rspec-its

Excess typing can hasten the eventual heat death of the universe.

Rspec-its lets your examples be shorter, thus preventing excess typing, and the eventual heat death of the universe.

its(:thingy) { should whatever }

I've been using it for some time... but wondered what to do when I wanted to match on something that wasn't just a parameterless method call on the subject.

When all else fails... RTFM.

And there I immediately found the syntax I desired.

https://github.com/rspec/rspec-its

## Nested attributes.

You can check properties of a child object by using "foo.bar" syntax.  Since symbols don't allow dots, quote the expression:

its("user.username") { should be == 'fred' }

This can be chained out as far as you like.

## Hash values

When your subject is a hash, using bare symbols as the argument to its() doesn't do hash lookups - it calls hash methods,
like .size or .empty?.  To do a has lookup, place the desired key (string, symbol, whatever) as the first element of 
an array:

```
its( [:thingy] ) { should whatever }  #  invokes subject[:thingy]
its( ['thingy'] ) { should whatever }  #  invokes subject['thingy']
```

## Hashes within hashes.

A longer array does lookups within nested hashes.

```ruby
subject { { name: 'fred', address: { city: 'Chicago', state: 'IL'} } }
its( [:name] ) { should be == 'fred' }
its( [:address] ) { should be_kind_of Hash }
its( [:address, :city] ) { should be == 'Chicago' }   # subject[:address][:city]
```

