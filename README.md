Bookmark Manager
====================

Bookmark Manager is the Week 6 project I worked on at [Makers Academy](http://www.makersacademy.com).
The main aim of the project is creating a to build a bookmark manager service, similar to [pineapple.io](pineapple.io) or [delicious.com](delicious.com) in spirit.

The domain model, as presented to us, can be described as so:

>We are going to build a bookmark manager, similar to pineapple.io or delicious.com in spirit. A bookmark manager is a good use case for exploring how relational databases work.
>A bookmark manager is a website that maintains a collection of links, organised by tags. You can use it to save a webpage you found useful. You can add tags to the webpages you saved to find them later. You can browse links other users have added.

>The website will have the following options:

* Show a list of links from the database.

* Add new links.

* Add tags to the links.

* Filter links by a tag.

>A user will be able to:

* Sign up to the service.

* Sign in to the service.

* Edit the password





* The feature I implemented via TDD are:

  1. A Ship object, which contains coordinates, and can be hit and sunk.

  2. A Grid object, which allows the player to see their shots and their ships (if they are defending in that round).

  3. A Coordinate object, which is able to store and translate the coordinates needed to place the ships and target them.

  4. A Player object, which has 5 Ships, 2 Grids and 2 Coordinate systems. A player can be either active or inactive, and can place ships.

  5. A BattleShips object, which has 2 Players, and contains all the application logic and user interaction.

* The programming languages and technologies I used are:

  * Ruby

  * Rspec

* How to run the application:

  * From command line enter: 
```bash
git clone git@github.com:federicomaffei/battleships.git
cd battleships
ruby lib/battleships_ruby_app.rb
```

* How to test the application:

  * From command line enter:
```bash
git clone git@github.com:federicomaffei/battleships.git
cd battleships
rspec
```
* Possible future adds to the features:

  * Throw exception messages when the user input is not consistent for coordinates and shots.

  * Add a choice at each shot so that the user can see the attacking grid only if he/she wants.