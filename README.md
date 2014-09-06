Bookmark Manager
====================

Bookmark Manager is the Week 6 project I worked on at [Makers Academy](http://www.makersacademy.com).
The main aim of the project is to build a bookmark manager service, similar to [pineapple.io](pineapple.io) or [delicious.com](delicious.com) in spirit.

![BOOKMARK](https://dl.dropboxusercontent.com/u/9315601/bookmark.png)

The domain model, as presented to us, can be described as so:

>We are going to build a bookmark manager, similar to pineapple.io or delicious.com in spirit. A bookmark manager is a good use case for exploring how relational databases work.
>A bookmark manager is a website that maintains a collection of links, organised by tags. You can use it to save a webpage you found useful. You can add tags to the webpages you saved to find them later. You can browse links other users have added.
>The website will have the following options:
>* Show a list of links from the database.
>* Add new links.
>* Add tags to the links
>* Filter links by a tag.
>A user will be able to:
>* Sign up to the service.
>* Sign in to the service.
>* Edit the password.

====================

##The features I implemented via TDD are:

1. As a User, when browsing the homepage, I can add a link, complete with tags.

2. As a User, when browsing the search page, I can filter the links by tag.

3. As a User, I can sign in, and have my credentials checked as email and password.

4. As a User, I can sign up.

5. As a User, I can sign out.

====================

###The programming languages and technologies I used are:

* Ruby

* Rspec

* Sinatra

* Capybara

====================

###How to run the application:

* In the browser enter: [http://bkmanager.herokuapp.com/](http://bkmanager.herokuapp.com/)

###How to test the application:

* From command line enter:
```bash
git clone git@github.com:federicomaffei/bookmark_manager.git
cd bookmark_manager
rspec
```

====================

###Possible future adds to the features:

* Add a brief description to each link.

* Add the chance for the user to review each link, and show overall results.