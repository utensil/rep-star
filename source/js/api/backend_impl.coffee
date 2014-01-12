class BackendImpl extends Backend
  constructor: (conf) ->
    # ...
  
  call: (method, arg, fn) ->
    return Q(
      view: "nothing"
    )