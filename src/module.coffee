
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
    @::_connectedClasses.push(cls)
    @[cls.className] = cls if cls.className

  _connectedClasses: []

  _init: ->

  opts: {}

  constructor: (opts) ->
    $.extend @opts, opts


    instances = for cls in @_connectedClasses
      name = cls.name.charAt(0).toLowerCase() + cls.name.slice(1)
      @[name] = new cls(@)

    @_init()

    instance._init?() for instance in instances

  destroy: ->


class Plugin extends Module

  opts: {}

  constructor: (@widget) ->
    $.extend(@opts, @widget.opts)

  _init: ->


window.Module = Module
window.Widget = Widget
window.Plugin = Plugin

