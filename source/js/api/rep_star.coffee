RepStar = (conf) ->
  self = $.observable(this)
  backend = BackendFactory.create(conf)
  data = data || {}

  $.extend(self, conf)

  # load a given page from the server
  self.load = (page, fn) ->

    self.trigger("before:load")

    self.one("load", fn)

    backend.call "load", page, (view) ->
      self.trigger("load", view)

  # ... other API methods goes here

  # same as load("search")
  #self.search = function(query, fn) {
  #  return backend.call("search", query, fn);
  #};

  # initialization
  backend.call("init", conf.page).then (data)->
    self.user = new User(self, (if data then data.user else {}), backend)
    self.trigger("ready")
    self.trigger("load", data.view)
  .fail (err)->
    # nothing yet
    console.error(err)
  .done()

  # on each "page" load
  self.on "load", (view) ->
    self.trigger("load:" + view.type, view.data, view.path)
    self.page = view.type
