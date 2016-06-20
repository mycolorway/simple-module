expect = chai.expect

describe 'SimpleModule', ->

  class TestPlugin extends SimpleModule
    constructor: (@module) ->
      super()
      this.test = true
    start: ->
      this.started = true

  it 'should support custom events', ->
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

    module.one 'customEvent', listener
    module.trigger 'customEvent'
    module.trigger 'customEvent'
    expect(callCount).to.be.equal(3)

  it 'can extend properties', ->
    extendWithWrongArgs = ->
      SimpleModule.extend 'test'
    expect(extendWithWrongArgs).to.throw(/param should be an object/)

    SimpleModule.extend
      classProperty: true
    expect(SimpleModule.classProperty).to.be.equal(true)

  it 'can include prototype properties', ->
    includeWithWrongArgs = ->
      SimpleModule.include 'test'
    expect(includeWithWrongArgs).to.throw(/param should be an object/)

    SimpleModule.include
      prototypeProperty: true
    module = new SimpleModule()
    expect(SimpleModule.prototype.prototypeProperty).to.be.equal(true)
    expect(module.prototypeProperty).to.be.equal(true)

  it 'can register plugin', ->
    registerWithoutName = ->
      SimpleModule.plugin()
    expect(registerWithoutName).to.throw(/first param should be a string/)
    expect(SimpleModule.plugins.testPlugin).to.be.undefined

    registerWithoutClass = ->
      SimpleModule.plugin('testPlugin')
    expect(registerWithoutClass).to.throw(/second param should be a class/)
    expect(SimpleModule.plugins.testPlugin).to.be.undefined

    SimpleModule.plugin 'testPlugin', TestPlugin
    expect(SimpleModule.plugins.testPlugin).to.be.equal(TestPlugin)

  it 'can create instance with plugin', ->
    SimpleModule.plugin 'testPlugin', TestPlugin
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
        $.extend @opts, ModuleA.opts, opts

    class ModuleB extends ModuleA
      @opts:
        name: 'B'
      constructor: (opts) ->
        super()
        $.extend @opts, ModuleB.opts, opts

    moduleB = new ModuleB()
    moduleA = new ModuleA()
    module = new SimpleModule()
    moduleX = new ModuleB
      name: 'X'

    expect(moduleB.opts.name).to.be.equal('B')
    expect(moduleA.opts.name).to.be.equal('A')
    expect(module.opts.name).to.be.undefined
    expect(moduleX.opts.name).to.be.equal('X')
