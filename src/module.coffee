class Module

  @extend: (obj) ->
    return unless obj? and typeof obj is 'object'
    for key, val of obj when key not in ['included', 'extended']
      @[key] = val
    obj.extended?.call(@)

  @include: (obj) ->
    return unless obj? and typeof obj is 'object'
    for key, val of obj when key not in ['included', 'extended']
      @::[key] = val
    obj.included?.call(@)

  @connect: (cls) ->
    return unless typeof cls is 'function'

    unless cls.name
      throw new Error 'Widget.connect: cannot connect anonymous class'
      return

    cls::_connected = true
    @_connectedClasses = [] unless @_connectedClasses
    @_connectedClasses.push(cls)
    @[cls.name] = cls if cls.name


  opts: {}

  constructor: (opts) ->
    @eventDelegate = {}
    @opts = $.extend({}, @opts, opts)

    @constructor._connectedClasses ||= []

    instances = for cls in @constructor._connectedClasses
      name = cls.name.charAt(0).toLowerCase() + cls.name.slice(1)
      cls::_module = @ if cls::_connected
      @[name] = new cls()

    if @_connected
      @opts = $.extend @_module.opts, @opts
    else
      @_init()
      instance._init?() for instance in instances

    @trigger 'initialized'

  _init: ->

  on: (args...) ->
    $(@eventDelegate).on args...
    @

  one: (args...) ->
    $(@eventDelegate).one args...
    @

  off: (args...) ->
    $(@eventDelegate).off args...
    @

  trigger: (args...) ->
    $(@eventDelegate).trigger args...
    @

  triggerHandler: (args...) ->
    $(@eventDelegate).triggerHandler args...

  _t: (args...) ->
    @constructor._t args...

  @_t: (key, args...) ->
    result = @i18n[@locale]?[key] || ''

    return result unless args.length > 0

    result = result.replace /([^%]|^)%(?:(\d+)\$)?s/g, (p0, p, position) ->
      if position
        p + args[parseInt(position) - 1]
      else
        p + args.shift()

    result.replace /%%s/g, '%s'

  @i18n:
    'zh-CN': {}

  @locale: 'zh-CN'



# monkey patch for IE to support Function.name
if Function.prototype.name == undefined && Object.defineProperty
  Object.defineProperty Function.prototype, 'name',
    get: ->
      re = /function\s+([^\s(]+)\s*\(/
      results = re.exec @toString()
      if (results && results.length > 1) then results[1] else ""
    set: (val) ->


