#!/usr/bin/env node

// grunt is messy, shelljs is not (https://github.com/arturadib/shelljs)

require('shelljs/make');

var gaze = require('gaze'),
  less = require('less'),
  header = ";(function(top) {",
  footer = '})(typeof top == "object" ? window : exports);',
  coffee = require('coffee-script');

// initialize repository
function init() {
  mkdir("-p", "dist");
}

var src = 'source';
var js_src = src + '/js';
var js_libs = js_src + '/libs'
var app_name = 'rep-star';

//compile coffee scripts to js as string
function compile_coffee(source) {
  console.log('compile_coffee', source);
  return coffee.compile(cat(source), {});
}

function coffee_or_js(source) {
  if(typeof source != typeof "")
  {
    throw "source must be String, got: " + source;
  }  

  return cat(source + '.js') + compile_coffee(source + '.coffee');
}

// Function to compile a single less file
function compile_less(source, target) {
  console.log('compile_less', source, target);

  var dir = source.split("/").slice(0, -1).join("/");

  var parser = new(less.Parser)({
    // Specify search paths for @import directives
    paths: [dir], 
    // Specify a filename, for better error messages        
    filename: source      
  });

  parser.parse(cat(source), function (err, tree) {
    if (err) throw err;
    // Minify CSS output
    tree.toCSS({ compress: true }).to(target); 
  });
}

// Make a single file out of everything
function concat() {

  init();

  // riot.js
  var js = cat(js_libs + "/riotjs/riot.js");

  // api
  js += header + coffee_or_js(js_src + "/api/*") + footer;

  // ui
  js+= coffee_or_js(js_src + "/ui/*");

  // dist
  js.to("dist/rep-star.js");

}

// Test the API on server side (node.js)
target.test = function() {

  init();

  // generate API files
  (header + cat(src + "/api/*.js") + footer).to("dist/api.js");

  // run tests
  require("./test/index.js");
}


target.lint = function() {
  exec("jshint " + js_src);
}

// return target.test();

// concat target
target.concat = concat;


// generate application
target.gen = function() {
  concat();
  compile_less(src + "/less/style.less", "dist/style.css");
  cp("-f", js_libs + "/jquery/jquery.min.js", "dist");
};

// watch for changes: ./make.js watch
target.watch = function() {

  // scripts
  gaze([js_src + "/**/*.js", js_src + "/**/*.coffee"], function() {
    this.on('all', function(e, file) {
      concat();
    });
  });

  // styles
  gaze(src + "/less/*.less", function() {
    this.on('changed', function(e, file) {
      compile_less(src + "/less/style.less", "dist/style.css");
    });
  });

};

