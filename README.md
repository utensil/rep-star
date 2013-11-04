Rep Star
====================

[![Build Status](https://travis-ci.org/utensil/rep-star.png?branch=master)](https://travis-ci.org/utensil/rep-star)
[![Coverage Status](https://coveralls.io/repos/utensil/rep-star/badge.png)](https://coveralls.io/r/utensil/rep-star)
[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/utensil/rep-star/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

A nearly backendless HTML5 app to manage starred repositories of Github and more.

Rationale
-----------

Github is like a great mall to do window shopping. I love starring repositories. I meet them by exploring the trending repositories or by some searching on a subject. But I find it hard to organize them, except by gisting or blogging about a series of them.

I intend to scratch this itch since the project [jquery-github-widget](https://github.com/utensil/jquery-github-widget), it's completed as a widget but didn't reach the point to become a tool. And then there was [CodeShelver](https://www.codeshelver.com/) and soon it became  unaccessible, and then Github improved starring a little bit, so I lived with it. 

Recently I discovered [GitRep](http://gitrep.com/), but it seems to be very inconvenient, and I would stop loving it one day. Starring and the organizing should last longer than just a tool, a site and just one way of interacting with them, I want to leave a tool easily and still not lose the track.

So, backendless. To be more precise, no backend other than a Github user already has. The idea is simple, just to use HTML5 localStorage for local storage and a special gist file for cloud storage. 

But in order to modify a user's gist, some OAuth thing must be done, this is where oauth.io comes in. It provides a nearly backendless solution for OAuth, and the its core is open-sourced and thus can be replaced. oauth.io can become unnecessary one day, when a user create his/her own application and store the secrets on the client side.

That's pretty much it, and it's just waiting to be implemented.

Development Status
----------------------

Early stage. Basically nothing is completed yet.

Tech Choices
--------------

### Toolchain

* [Bower](http://bower.io/) for browser js package management
* [RequireJS](requirejs.org) for AMD style module management
* [GruntJS](http://gruntjs.com/) for task running
* [Livereload](https://github.com/intesso/connect-livereload) for rapid development
* [Karma](http://karma-runner.github.io/0.8/index.html) for testing

### Framework

* [AngularJS](http://www.angularjs.org/) for MVVM style single-page app development.

### Languages

* [Jade](http://jade-lang.com/) for HTML (not yet)
* [CoffeeScript](http://coffeescript.org/) for JavaScritping
* [Less](http://lesscss.org/) for CSS

### API

* [oauth.io](https://oauth.io) for Github OAuth
* [oboe.js](https://github.com/jimhigson/oboe.js) for JSON Streaming and partially implement Github API
* more

License
--------

MIT Licence, see LICENSE.
Copyright (c) 2013 Utensil Song (https://github.com/utensil)

Installation
----------------

```
  # install global npm dependencies
  npm -g install grunt-cli
  npm -g install bower
  npm -g install karma
  npm -g install coffee-script
  
  # get bower dependencies
  bower install
  
  # also to be able to run tests from cli
  # without browser window popping
  # consider to install PhantomJS
  http://phantomjs.org/download.html
  phantomjs -v

  # get npm dependencies
  npm install
```

Usage
-----------

There are several grunt tasks available:

* `grunt`, `grunt build` will build project into `build` directory. It compiles project into single file, minifies it and compiles styles.
* `grunt preview` runs `grunt build` and preview the build result by starting a static http server
* `grunt dev` starts livereload server for development
* `grunt test` starts karma test runner with `singleRun: true` enabled
* `grunt ci` is used in Travis CI, and it report test coverage information to coveralls.io



