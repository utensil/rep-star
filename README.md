Rep Star
====================

A nearly backendless HTML5 app to manage starred repositories of Github and more.

Rationale
-----------

Github is like a great mall to do window shopping. I love starring repositories. I met them by exploring the trending repositories or by some searching on a subject. But I find it hard to organize them, except by gisting or blogging about a series of them.

I intend to scratch this itch since the project [jquery-github-widget](https://github.com/utensil/jquery-github-widget), it's completed as a widget but didn't reach the point to become a tool. And then there was [CodeShelver](https://www.codeshelver.com/) and soon it became  unaccessible, and then Github improved starring a little bit, so I lived with it. 

Recently I discovered [GitRep](http://gitrep.com/), but it seems to be very inconvenient, and I would stop loving it one day. Starring and the organizing should last longer than just a tool, a site and just one way of interacting with them, I want to leave a tool easily and still not lose the track.

So, backendless. To be more precise, no backend other than a Github user already has. The idea is simple, just to use HTML5 localStorage for local storage and a special gist file for cloud storage. 

But in order to modify a user's gist, some OAuth thing must be done, this is where oauth.io comes in. It provides a nearly backendless solution for OAuth, and the its core is open-sourced and thus can be replaced. oauth.io can become unnecessary one day, when a user create his/her own application and store the secrets on the client side.

That's pretty much it, and it's just waiting to be implemented.

Development Status
----------------------

[![Build Status](https://travis-ci.org/utensil/rep-star.png?branch=master)](https://travis-ci.org/utensil/rep-star)
[![Coverage Status](https://coveralls.io/repos/utensil/rep-star/badge.png)](https://coveralls.io/r/utensil/rep-star)


Early stage. Basically nothing is completed yet.

License
--------

MIT Licence, see LICENSE.
Copyright (c) 2013 Utensil Song (https://github.com/utensil)

Installation
----------------

```
  # get npm dependencies
  npm install

  # install global npm dependencies
  npm -g install grunt-cli
  npm -g install bower
  npm -g install karma
  npm -g install coffee-script

  # also to be able to run tests from cli
  # without browser window popping
  # consider to install PhantomJS
  http://phantomjs.org/download.html

  # get ruby dependencies
  bundle install
```

Usage
-----------

There are several grunt tasks available:

* `grunt server` starts livereload server for development
* `grunt test` starts karma test runner with `singleRun: true` enabled, good to use in CI scenarios
* `grunt compass` compiles compass project
* `grunt`, `grunt build` will build project into `build` directory. It compiles project into single file, minifies it and compiles styles.

Libs update
-------------

To update all the dependencies to latest compatible versions run `bower install`.

Tests
--------

Tests use Jasmin and Chai (optional, can be enabled per spec) for assertions.

[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/utensil/rep-star/trend.png)](https://bitdeli.com/free "Bitdeli Badge")
