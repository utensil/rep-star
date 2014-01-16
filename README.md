Rep Star
====================

[![Build Status](https://travis-ci.org/utensil/rep-star.png?branch=lite)](https://travis-ci.org/utensil/rep-star)
[![Coverage Status](https://coveralls.io/repos/utensil/rep-star/badge.png)](https://coveralls.io/r/utensil/rep-star)
[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/utensil/rep-star/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

A nearly backendless HTML5 app to manage starred repositories of Github and more.
  
rationale
-----------

For rationale regarding this project, please refer to [the master branch](https://github.com/utensil/rep-star/tree/master) , here describes why a "lite" branch:

AngularJS is heavy, Karma is heavy, RequireJS is cubersome, I'm kind of losing the fun compared to writing jQuery, and feels like being prisoned. The asset pipeline used in the master branch is heavy: grunt, temp files, oh no.

I would like try something else. Use harp or possibly gulp or simply shelljs as asset pipeline, and use Riot.js and jQuery to write the app.

Development Status
----------------------

Early stage. Basically nothing is completed yet.

Tech Choices
--------------

### Toolchain

* [Bower](http://bower.io/) for browser js package management
* [ShellJS](https://github.com/arturadib/shelljs) for compiling

### Framework

* [RiotJS](https://github.com/moot/riotjs) for MVP style single-page app development.

### Languages

* [Jade](http://jade-lang.com/) for HTML?
* [CoffeeScript](http://coffeescript.org/) for JavaScripting
* [Less](http://lesscss.org/) for CSS

### API

* [oauth.io](https://oauth.io) for Github OAuth
* more

License
--------

MIT Licence, see LICENSE.
Copyright (c) 2013 Utensil Song (https://github.com/utensil)

Installation
----------------

```
  # install global npm dependencies
  npm -g install bower
  npm install -g coffee-script
  npm install -g jshint
  npm install -g coffeelint
  npm install -g http-server

  # get bower dependencies
  bower install

  # get npm dependencies
  npm install
```
