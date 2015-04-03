
# Factory Girl Traits

Factory Girl provides "traits", which can reduce tedious boilerplate code when creating objects.  A trait can supply a value for a simple attribute or an association.

I had a number of tests involving a SpecialOffer - a coupon, that is, which would be applied to a ShoppingCart.  A SpecialOffer has many OfferEffects - matchers for product types that would give differing levels of discount (ie, 10% off tomatoes and peppers,  20% off onions and grapes, no effect at all on bagels).

This meant repeated creation of a SpecialOffer together with at least one OfferEffect.

## The Obvious Way

```ruby
 let(:offer) { 
    create(:special_offer, ...).tap do |o|
      o.offer_effects << create(:offer_effect, ...)
    end
 }
```

After having three such blocks in one file (with only slight differences in the attributes, such as coupon status and expiration date), I looked for a better way.

## The Better Way

Traits let you define a name by which you can supply values for one or more of the object's attributes.

```ruby
factory :special_offer do
   name "my offer"
   start_at Time.now
   end_at Time.now + 1.year

   trait :with_one_effect do
     # attribute_name { block-returning-value }
     offer_effects {  [ create(:offer_effect) ] }
  end
end
```

(In this case, the attribute I'm supplying a value for is an ActiveRecord collection - hence the square brackets, as I make an array out of my newly created offer_effect, then assign all members of that array to the offer_effects collection).

To use it:

```ruby
    let(:offer) { create(:special_offer, :with_one_effect, other_attrs) }
```

This is convenient mainly because I wanted something generic for the members of other_effects; if I wanted more control of those I'd likely return to the original syntax , or define another factory that makes those explicit.


