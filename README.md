Rep Star
====================

A nearly backendless HTML5 app to manage starred repositories of Github and more.

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