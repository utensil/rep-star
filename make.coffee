#!/usr/bin/env node

# grunt is messy, shelljs is not (https:# github.com/arturadib/shelljs)

require "shelljs/make"

gaze = require "gaze"
less = require "less"
header = ';(function (top) {'
footer = '})(typeof top == "object" ? window : exports);'
coffee = require "coffee-script"
_ = require "lodash"

# initialize repository
init = ->
  mkdir("-p", "dist")

src = "source"
js_src =  "#{src}/js"
js_libs = "#{js_src}/libs"
app_name = "rep-star"

# compile coffee scripts to js as string
compile_coffee = (source) ->
  console.log "compile_coffee", source
  
  coffee.compile cat(source), {}

coffee_or_js = (source) ->
  unless _.isString(source)
    throw new Error("source must be String, got: #{source}")

  cat("#{source}.js") + compile_coffee("#{source}.coffee")

# Function to compile a single less file
compile_less = (source, target) ->
  console.log "compile_less", source, target

  dir = source.split("/").slice(0, -1).join("/")

  parser = new(less.Parser)(
    # Specify search paths for @import directives
    paths: ['.', dir, js_libs]
    # Specify a filename, for better error messages
    filename: source
  )

  parser.parse cat(source), (err, tree) ->
    if (err)
      throw err
    # Minify CSS output
    tree.toCSS({ compress: true }).to(target)

# Make a single file out of everything
concat = ->
  # riot.js
  js = cat(js_libs + "/riotjs/riot.js")

  # api
  js += header + coffee_or_js("#{js_src}/api/*") + footer

  # ui
  js+= coffee_or_js("#{js_src}/ui/*")

  # dist
  js.to("dist/rep-star.js")

cp_html = ->
  console.log "cp_html"
  cp '-rf', ["#{src}/index.html"], 'dist/'


cp_jslibs = ->
  console.log "cp_jslibs"
  cp("-f", [
    "#{js_libs}/jquery/jquery.min.js"
    "#{js_libs}/q/q.js"
    "#{js_libs}/lodash/dist/lodash.min.js"
  ], "dist")

# Test the API on server side (node.js)
target.test = ->
  init()

  # generate API files
  (header + coffee_or_js("#{js_src}/api/*") + footer).to("dist/api.js")

  # run tests
  require("./test/index.coffee")

target.all = ->
  target.lint()
  target.gen()

target.lint = ->
  exec "jshint #{js_src}"
  exec "coffeelint make.coffee"
  exec "coffeelint #{js_src}"

# concat target
target.concat = concat

#  generate application
target.gen = ->
  init()
  concat()
  cp_html()
  cp_jslibs()
  compile_less("#{src}/less/style.less", "dist/style.css")

#  watch for changes: ./make.js watch
target.watch = ->
  # html
  gaze ["#{src}/index.html"], ->
    this.on "changed", (e, file) ->
      cp_html()

  # scripts
  gaze ["#{js_src}/**/*.js", "#{js_src}/**/*.coffee"], ->
    this.on "all", (e, file) ->
      concat()

  # styles
  gaze "#{src}/less/*.less", ->
    this.on "changed", (e, file) ->
      compile_less("#{src}/less/style.less", "dist/style.css")


