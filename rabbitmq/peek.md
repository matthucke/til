# Peek at Messages

I have various applications that pass messages to each other via RabbitMQ.  Queues are generally empty, or have only a few messages, as they get serviced fairly quickly.

But now I have an app that will service messages very slowly, sometimes taking half an hour or more to handle one.

Naturally, my users will want to see what jobs are in the queue, using an admin web app.

RabbitMQ does not provide an official way to see messages in a queue without consuming them.

## Workaround: Get without Ack

As I discovered in StackOverflow discussions, one can peek at messages by reading them - the same way a consumer would - but closing the connection without ACK'ing them.  The messages are thus returned to the queue, in the same order in which they were read.

```ruby
connection = Bunny.new
channel = connection.create_channel
channel.prefetch 1

# note that the channel properties must match those used when the
# channel was created for real, else you get an error
queue = channel.queue("foo", durable: true)
queue.message_count.times do
  # msg will be nil if queue becomes empty (ie, someone else ate our message)
  if msg = queue.get(manual_ack: true)
    @message_list.push msg
  end
end
connection.close
```

The "manual_ack: true" is what separates this Peek operation from a normal message consumer.  By promising to ack - then hanging up without doing so - we trick RabbitMQ into requeuing everything.

## Does it scale?
I've tested this on a queue with 100 messages, each consisting of 300 dictionary words, without any problems; messages are restored to the queue in the same order they were created.  As my queues tend to be small I have not attempted this with large messages or large message counts.
