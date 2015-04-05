# Angular vs. Rails CSRF

Upon initially POSTing to a Rails back-end, my Angular app was rejected due to not having the form authenticity token.

## The obvious jQuery way

Because Rails rendered the form that Angular is attached to, I could manually grab the token from the hidden field:

```coffeescript
token = $('input[name=authenticity_token]').val()

post_data = $.extend( whatever, { authenticity_token: token })
$http.post( json_url, post_data) ...

```

This works, but I have to remember to do it every time; and it won't work for forms that weren't created using Rails's form helper.  Worst of all, it's ugly and non-idiomatic; I don't want Angular devs  thinking I just fell off the turnip truck yesterday.

## A more automatic and Angular way

A [StackOverflow post](http://stackoverflow.com/questions/14734243/rails-csrf-protection-angular-js-protect-from-forgery-makes-me-to-log-out-on) provided the answer.  The questioner approved an answer that involved overriding much of Rails's CSRF token handling - which is OK, but I prefer BinaryMuse's answer that appeared just below.

When initializing the app, grab the token from the META tags and add it as a default HTTP header:

```coffeescript
# Place CSRF token into every HTTP request.
root.tubesApp.config ["$httpProvider", ($httpProvider) ->
  if token=$('meta[name=csrf-token]').attr('content')
    $httpProvider.defaults.headers.common['X-CSRF-Token'] = token
]
```

## Proving it works

Simply examine the request headers using the javascript console - they'll have something like: 

X-CSRF-Token: jNp9v+CoewEA500C8mSG......+Xa1ELjSbiA==
