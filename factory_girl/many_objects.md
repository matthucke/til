# Create Many Objects with Factory Girl

I needed a single factory that would generate many objects with predefined values.

Why?  Because I needed to assemble them into a tree-like structure, and test how to find elements within that structure.  A handful of objects would not do, nor did I want to create factories with individual names that I'd have to type - I had no interest in the individual objects (which are trivial), only the collection.

## First Approach

I first transformed my data into a list of factories, by parsing a file, looping through it, and outputting a `factory` block for each.

```ruby
factory :captain_kirk,  parent: :starfleet_officer do
	first_name 'James'
	last_name 'Kirk'
end

factory :lieutenant_sulu, parent: :starfleet_officer do
    first_name 'Hikaru'
    last_name 'Sulu'
end
```

This, of course, became unwieldy - the file was a mile long and not at all DRY.  And how would I get the whole set, other than by referring to each by name?

Not happy.  I deleted all of those generated factories.

## Many builds make an Array

I found an answer by considering these facts:

* FactoryGirl works with all classes, not just ActiveRecord
* initialize_with { ... } can do anything you can imagine
* that includes invoking other factories (`create` or `build`)

That gave me my answer - iterate over the raw data within an initialize_with that builds an array.

```ruby
    # Put the data for all these objects into an easily parsed string
    OFFICER_DATA = YAML.load << END
    -
        first_name: James
        last_name: Kirk
        rank: Captain
    -
        last_name: Spock
        rank: Commander
    END

    # and make a factory that builds them all:
    factory :bridge_crew, class: 'Array' do
        initialize_with {
          OFFICER_DATA.map { |attrs| build(:starfleet_officer, attrs) }
        }
    end
```

Calling 'build' within the loop will invoke a previously defined `starfleet_officer` factory; the factory then returns the array.  The `class: Array` in the factory arguments is there solely to stop FactoryGirl from constantizing the factory name.

Note that I had to choose  whether to `build` or `create` the objects within the loop - I choose `build`, which gives speed and flexibility; I could always do `map(&:save!)` on the resulting array - from the caller - if I really needed to persist them all.




