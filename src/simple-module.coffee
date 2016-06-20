class SimpleModule

  # Add properties to {SimpleModule} class.
  #
  # @param [Object] obj The properties of {obj} will be copied to {SimpleModule}
  #                     , except property named `extended`, which is a function
  #                     that will be called after copy operation.
  @extend: (obj) ->
    unless obj and typeof obj == 'object'
      throw new Error('SimpleModule.extend: param should be an object')

    for key, val of obj when key not in ['included', 'extended']
      @[key] = val

    obj.extended?.call(@)
    @

  # Add properties to instance of {SimpleModule} class.
  #
  # @param [Hash] obj The properties of {obj} will be copied to prototype of
  #                   {SimpleModule}, except property named `included`, which is
  #                   a function that will be called after copy operation.
  @include: (obj) ->
    unless obj and typeof obj == 'object'
      throw new Error('SimpleModule.include: param should be an object')

    for key, val of obj when key not in ['included', 'extended']
      @::[key] = val

    obj.included?.call(@)
    @

  # @property [Hash] The registered plugins.
  @plugins: {}

  # Register plugin for {SimpleModule}
  #
  # @param [String] name The name of plugin.
  # @param [Function] cls The class of plugin.
  #
  @plugin: (name, cls) ->
    unless name and typeof name == 'string'
      throw new Error 'SimpleModule.plugin: first param should be a string'

    unless typeof cls == 'function'
      throw new Error 'SimpleModule.plugin: second param should be a class'

    @plugins[name] = cls
    @

  @opts:
    plugins: []

  plugins: {}

  # Create a new instance of {SimpleModule}
  #
  # @param [Hash] opts The options for initialization.
  #
  # @return The new instance.
  constructor: (opts) ->
    @opts = $.extend {}, SimpleModule.opts, opts

    @opts.plugins.forEach (name) =>
      @plugins[name] = new SimpleModule.plugins[name](@)

  on: (args...) ->
    $(@).on args...

  off: (args...) ->
    $(@).off args...

  trigger: (args...) ->
    $(@).triggerHandler(args...)

  one: (args...) ->
    $(@).one args...

module.exports = SimpleModule
