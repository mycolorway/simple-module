SimpleModule = require '../src/simple-module.coffee'
_ = require 'lodash'
expect = require('chai').expect

describe 'SimpleModule', ->

  it 'should inherit from EventEmitter', ->
    module = new SimpleModule()
    callCount = 0
    listener = ->
      callCount += 1

    module.on 'customEvent', listener
    module.trigger 'customEvent'
    expect(callCount).to.be.equal(1)
    module.off 'customEvent'
    module.trigger 'customEvent'
    expect(callCount).to.be.equal(1)

    module.on 'customEvent', listener
    module.trigger 'customEvent'
    expect(callCount).to.be.equal(2)
    module.off 'customEvent', listener
    module.trigger 'customEvent'
    expect(callCount).to.be.equal(2)

  it 'should support mixins', ->
    SimpleModule.extend
      classProperty: true

    SimpleModule.include
      prototypeProperty: true

    module = new SimpleModule()

    expect(SimpleModule.classProperty).to.be.equal(true)
    expect(SimpleModule.prototype.prototypeProperty).to.be.equal(true)
    expect(module.prototypeProperty).to.be.equal(true)

  it 'can have plugins', ->
    class TestPlugin extends SimpleModule
      constructor: (@module) ->
        super()
        this.test = true
      start: ->
        this.started = true

    SimpleModule.plugin 'testPlugin', TestPlugin
    expect(SimpleModule.plugins.testPlugin).to.be.equal(TestPlugin)

    module = new SimpleModule
      plugins: ['testPlugin']

    expect(module.plugins.testPlugin instanceof TestPlugin).to.be.equal(true)
    expect(module.plugins.testPlugin.test).to.be.equal(true)

    module.plugins.testPlugin.start()
    expect(module.plugins.testPlugin.started).to.be.equal(true)

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

    expect(moduleB.opts.name).to.be.equal('B')
    expect(moduleA.opts.name).to.be.equal('A')
    expect(module.opts.name).to.be.undefined
    expect(moduleX.opts.name).to.be.equal('X')
