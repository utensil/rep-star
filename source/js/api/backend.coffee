class Backend

  constructor: (conf) ->
    # nothing

  call: (method, arg, fn) ->
    # MUST implement
    throw new Error("A backend MUST implement call(method, arg, fn)")