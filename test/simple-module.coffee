SimpleModule = require '../dist/simple-module.js'
_ = require 'lodash'

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
        super()
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

  it 'should let subclasses override default options', ->
    class ModuleA extends SimpleModule
      @opts:
        name: 'A'
      constructor: (opts) ->
        super()
        _.extend @opts, ModuleA.opts, opts

    class ModuleB extends ModuleA
      @opts:
        name: 'B'
      constructor: (opts) ->
        super()
        _.extend @opts, ModuleB.opts, opts

    moduleB = new ModuleB()
    moduleA = new ModuleA()
    module = new SimpleModule()
    moduleX = new ModuleB
      name: 'X'

    expect(moduleB.opts.name).toBe('B')
    expect(moduleA.opts.name).toBe('A')
    expect(module.opts.name).toBeUndefined()
    expect(moduleX.opts.name).toBe('X')
