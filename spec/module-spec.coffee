
describe 'Simple Module', ->
  class TestModule extends SimpleModule
    opts:
      moduleName: 'Test Module'

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
      opts:
        pluginName: 'Test Plugin'
    TestModule.connect TestPlugin
    testModule = new TestModule
    expect(testModule.testPlugin.constructor).toBe(TestPlugin)
    expect(testModule.testPlugin._connected).toBe(true)
    expect(testModule.testPlugin._module).toBe(testModule)
    expect(testModule.testPlugin.opts.moduleName).toBe('Test Module')

  it 'should translate i18n key', ->
    $.extend TestModule.i18n,
      'zh-CN':
        'hello': '你好，%s!'
    testModule = new TestModule()
    expect(testModule._t('hello', 'farthinker')).toBe('你好，farthinker!')
    expect(TestModule._t('hello', 'farthinker')).toBe('你好，farthinker!')


