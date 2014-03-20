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

  on: (args...) ->
    $(@).on args...

  one: (args...) ->
    $(@).one args...

  off: (args...) ->
    $(@).off args...

  trigger: (args...) ->
    $(@).trigger args...

  triggerHandler: (args...) ->
    $(@).triggerHandler args...


class Widget extends Module

  @connect: (cls) ->
    return unless typeof cls is 'function'

    unless cls.className
      throw new Error 'Widget.connect: lack of class property "className"'
      return

    @_connectedClasses = [] unless @_connectedClasses
    @_connectedClasses.push(cls)
    @[cls.className] = cls if cls.className

  _init: ->

  opts: {}

  constructor: (opts) ->
    @opts = $.extend({}, @opts, opts)

    @constructor._connectedClasses ||= []

    instances = for cls in @constructor._connectedClasses
      name = cls.className.charAt(0).toLowerCase() + cls.className.slice(1)
      @[name] = new cls(@)

    @_init()

    instance._init?() for instance in instances

    @trigger 'pluginconnected'

  destroy: ->


class Plugin extends Module

  @className: 'Plugin'

  opts: {}

  constructor: (@widget) ->
    @opts = $.extend({}, @opts, @widget.opts)

  _init: ->


window.Module = Module
window.Widget = Widget
window.Plugin = Plugin
