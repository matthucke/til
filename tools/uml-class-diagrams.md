# On the Making of Class Diagrams

Applying the **Single Responsibility Principle**, along with [Sandi Metz' Rules for Developers](http://robots.thoughtbot.com/sandi-metz-rules-for-developers) leads to a huge number of very small classes and modules and mixins.

How to keep them straight?  UML Class Diagrams.

Long ago, in my Java / Phone Company days, I used Visio on Windows for this.  These days I never work on a Windows machine - I want something I can use from both Linux and Mac.

I tried three tools today, based on a Stack Overflow thread that generated some good recommendations before it was "closed as off-topic" :disappointed:.

## Poseidon for UML

Poseidon is a desktop app written in Java.  The Community edition is free, and installed in less than a minute.  Launching it I get a very Visio-like interface.

Unfortunately, it just didn't work (Ubuntu 12 & Java 7, up-to-date with patches).  Attempting to place a class object onto the canvas, I just get a spinning cursor - and a stack trace in the window I started it from.

That experiment ended quickly.

## GenMyModel

GenMyModel.com is an online service, running within the browser.  You place an object on the canvas by pressing a single letter ("c" for class, "p" for package, etc.) and then clicking the canvas.  Relationships are accessed similarly ("z" for generalization, "s" for association), then clicking the two shapes to connect.

Resizing and moving objects is easy - the relationship arrows will follow - and the diagram has an attractive appearance, with gradient filled boxes and easy-on-the-eyes fonts.

Unfortunately the free service tier is laughably inadequate - you have to pay a monthly fee for any usable level of service.

## Argo UML

Finally I tried ArgoUML.  The tool works, and I made a trivial diagram quickly, but the diagrams don't look as good as GenMyModel - they're simple black-and-white, the text is weirdly positioned in its containers, and the fonts seem - to my untrained eye - to lack antialiasing.  While it seems a powerful tool, the diagrams just aren't as pretty as GenMyModel.  Plus, I really liked being to select an object by letter without having to drag my mouse to the toolbar.

## the Winner...

GenMyModel, for now.  I paid for a subscription at the lowest level, $9 a month.  GenMyModel and Argo both claim to support the XMI interchange format, although Argo choked when I tried to import a file from GenMyModel - this may be something to explore later if I decide to change.


