SimpleModule = require '../dist/simple-module.js'

describe 'SimpleModule', ->

  it 'should inherit from EventEmitter', ->
    module = new SimpleModule()
    obj =
      listener: ->
        console.log 'customEvent triggered'
    spyOn obj, 'listener'

    module.on 'customEvent', obj.listener
    module.trigger 'customEvent'
    expect(obj.listener).toHaveBeenCalled()

  it 'should support mixins', ->
    SimpleModule.extend
      classProperty: true

    SimpleModule.include
      prototypeProperty: true

    module = new SimpleModule()

    expect(SimpleModule.classProperty).toBe(true)
    expect(SimpleModule.prototype.prototypeProperty).toBe(true)
    expect(module.prototypeProperty).toBe(true)

  it 'can have plugins', ->
    class TestPlugin extends SimpleModule
      constructor: (@module) ->
        this.test = true
      start: ->
        console.log 'start test'

    SimpleModule.plugin 'testPlugin', TestPlugin
    expect(SimpleModule.plugins.testPlugin).toBe(TestPlugin)

    module = new SimpleModule
      plugins: ['testPlugin']

    expect(module.plugins.testPlugin instanceof TestPlugin).toBe(true)
    expect(module.plugins.testPlugin.test).toBe(true)

    spyOn(module.plugins.testPlugin, 'start')
    module.plugins.testPlugin.start()
    expect(module.plugins.testPlugin.start).toHaveBeenCalled()
