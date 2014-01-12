class BackendFactory

  constructor: () ->
    # ...
  
  @create: (conf) ->
    new BackendImpl(conf)
