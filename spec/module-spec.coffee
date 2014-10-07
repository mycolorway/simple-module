
describe 'Simple Module', ->
  class TestModule extends SimpleModule

  it 'can be inherited from', ->
    testModule = new TestModule()
    expect(testModule instanceof SimpleModule).toBe(true)

  it 'can be extended by an object', ->
    TestModule.extend
      extendVar: true
    expect(TestModule.extendVar).toBe(true)

  it 'can include prototype variable', ->
    TestModule.include
      includeVar: true
    testModule = new TestModule()
    expect(testModule.includeVar).toBe(true)

  it 'can connect other class', ->
    class TestPlugin extends SimpleModule
      TestModule.connect TestPlugin
    testModule = new TestModule()
    expect(testModule.testPlugin?.constructor).toBeDefined()
    expect(testModule.testPlugin.constructor).toBe(TestPlugin)


