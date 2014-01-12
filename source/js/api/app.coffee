
instance = {}

top.app = $.observable (arg) ->
  # app() --> return instance
  if (!arg)
    return instance

  # app(fn) --> add a new module
  else if _.isFunction(arg)
    top.app.on "ready", arg

  # app(conf) --> initialize the application
  else
    instance = new RepStar(arg)

    instance.on "ready", () ->
      top.app.trigger("ready", instance)


