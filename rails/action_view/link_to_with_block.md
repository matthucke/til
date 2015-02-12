# extending link_to

I've never been in the habit of using link_to, mainly because HAML makes slapping custom attributes onto an anchor tag so easy.

But in my admin apps I use `target="_blank" ` frequently - to link to the edit pages for related objects - and got tired of typing it.

So I created a helper (in application_helper.rb):

```ruby
  def blank_to(name = nil, options = nil, html_options = nil, &block)
    html_options = {target: '_blank'}.merge(html_options || {})
    link_to(name, options, html_options, &block)
  end
```

This lets me do something like:

```haml
= blank_to @order.user.full_name, @order.user
```

## With a Block

Another reason I never cared much for link_to is that my anchor text is often not just a simple string - I might want formatting or an icon.

It was while examining the parameter list for link_to today that I discovered it takes a block.  Leave off the caption and pass a block instead:

```haml
= link_to @order.user do
  %img{src: "user_icon.png"}
  %br
  = @order.user.full_name
```
 
I'll be using link_to lots more after discovering the with-block version.

