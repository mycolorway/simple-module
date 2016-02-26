# {SimpleModule} provides mixins, plugin mechanism and event emitter for subclasses.
class SimpleModule

  # Add properties to {SimpleModule} class.
  #
  # @param [Object] obj The properties of {obj} will be copied to {SimpleModule},
  #   except property named `extended`, which is a function that will be called
  #   after copy operation.
  #
  @extend: (obj) ->
    unless obj and typeof(obj) == 'object'
      throw new Error('SimpleModule.extend: param should be an object')
      return

    for key, val of obj when key not in ['included', 'extended']
      @[key] = val

    obj.extended?.call(@)
    @

  # Add properties to instance of {SimpleModule} class.
  #
  # @param [Hash] obj The properties of {obj} will be copied to prototype of
  #   {SimpleModule}, except property named `included`, which is a function that
  #   will be called after copy operation.
  #
  @include: (obj) ->
    unless obj and typeof(obj) == 'object'
      throw new Error('SimpleModule.include: param should be an object')
      return

    for key, val of obj when key not in ['included', 'extended']
      @::[key] = val

    obj.included?.call(@)
    @

  # @property [Hash] The registered plugins.
  @plugins: {}

  @plugin: (name, cls) ->
    unless name and typeof name == 'string'
      throw new Error('SimpleModule.plugin: first param should be a string')
      return

    unless typeof cls == 'function'
      throw new Error('SimpleModule.plugin: second param should be a class reference')
      return

    @plugins[name] = cls

  # Default options
  opts: {
    plugins: []
  }

  constructor: (opts) ->
    @opts = $.extend({}, @opts, opts)

    @constructor._connectedClasses ||= []

    instances = for cls in @constructor._connectedClasses
      name = cls.pluginName.charAt(0).toLowerCase() + cls.pluginName.slice(1)
      cls::_module = @ if cls::_connected
      @[name] = new cls()

    if @_connected
      @opts = $.extend {}, @opts, @_module.opts
    else
      @_init()
      instance._init?() for instance in instances

    @trigger 'initialized'

  _init: ->

  on: (args...) ->
    $(@).on args...
    @

  one: (args...) ->
    $(@).one args...
    @

  off: (args...) ->
    $(@).off args...
    @

  trigger: (args...) ->
    $(@).trigger args...
    @

  triggerHandler: (args...) ->
    $(@).triggerHandler args...

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

module.exports = SimpleModule
