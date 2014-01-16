js_libs = "../source/js/libs"

require "#{js_libs}/riotjs/bdd.js"

global.$ = require "#{js_libs}/riotjs/riot.js"

global._ = require "lodash"

global.Q = require "q"

request = require 'request'

class JqXHR
  constructor: (response)->
    @response = response

  getResponseHeader: (name)->
    @response.headers[name.toLowerCase()]

# partially implement jQuery.ajax by request
global.$.ajax = (option = {}) -> 
  headers = option.headers || {}

  headers["User-Agent"] = "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/31.0.1650.63 Safari/537.36"

  request(
    # only 3 options and 2 callbacks
    method: option.method || "GET"
    url: option.url
    headers: headers
  , (error, response, body) ->
    jqXHR = 
    unless error
      option.success(body, response.statusCode, new JqXHR(response))
    else
      option.error(new JqXHR(response), response.statusCode, errorThrown)
  )
