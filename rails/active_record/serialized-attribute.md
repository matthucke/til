# Serialized Attribute

My shopping cart application must store large amounts of vendor-specific information for 
some complex items - such as floor mats that are highly customisable, with the user selecting 
logos, carpet colour, custom embroidered text, etc.

Not wanting to impose lots of structure on something that's needed only for the fraction
of a second that it takes to build the item - but that I want to save for debugging purposes
later - I chose to store it in a serialized field.

These are described here: http://apidock.com/rails/ActiveRecord/Base/serialize/class

```ruby
# alter table cart_items add item_properties text;

class CartItem < ActiveRecord::Base
  serialize :item_properties, Hash
end
```

This will cause the item_properties field in the database to be populated with the 
YAML serialization of the item_properties.

item_properties is always a Hash, as dictated by the second parameter to 'serialize'.
For a new object, this will be an empty hash; for an existing object, ActiveRecord will
require that the YAML deserializes to a hash.

```ruby
# Usage:

item = CartEngine::CartItem.new
item.item_properties # returns empty hash
item.attributes['item_properties']
item.save!    # writes null to DB

item.item_properties = { foo: 1, bar: 2}
item.save!    # writes "---\n:foo: 1\n:bar: 2\n" to item_properties column
```

