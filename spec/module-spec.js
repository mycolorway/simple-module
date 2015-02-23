(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  describe('Simple Module', function() {
    var TestModule;
    TestModule = (function(superClass) {
      extend(TestModule, superClass);

      function TestModule() {
        return TestModule.__super__.constructor.apply(this, arguments);
      }

      TestModule.prototype.opts = {
        moduleName: 'Test Module'
      };

      return TestModule;

    })(SimpleModule);
    it('can be inherited from', function() {
      var testModule;
      testModule = new TestModule();
      return expect(testModule instanceof SimpleModule).toBe(true);
    });
    it('can be extended by an object', function() {
      TestModule.extend({
        extendVar: true
      });
      return expect(TestModule.extendVar).toBe(true);
    });
    it('can include prototype variable', function() {
      var testModule;
      TestModule.include({
        includeVar: true
      });
      testModule = new TestModule();
      return expect(testModule.includeVar).toBe(true);
    });
    it('can connect other class', function() {
      var TestPlugin, testModule;
      TestPlugin = (function(superClass) {
        extend(TestPlugin, superClass);

        function TestPlugin() {
          return TestPlugin.__super__.constructor.apply(this, arguments);
        }

        TestPlugin.prototype.opts = {
          pluginName: 'Test Plugin'
        };

        return TestPlugin;

      })(SimpleModule);
      TestModule.connect(TestPlugin);
      testModule = new TestModule;
      expect(testModule.testPlugin.constructor).toBe(TestPlugin);
      expect(testModule.testPlugin._connected).toBe(true);
      expect(testModule.testPlugin._module).toBe(testModule);
      return expect(testModule.testPlugin.opts.moduleName).toBe('Test Module');
    });
    return it('should translate i18n key', function() {
      var testModule;
      $.extend(TestModule.i18n, {
        'zh-CN': {
          'hello': '你好，%s!'
        }
      });
      testModule = new TestModule();
      expect(testModule._t('hello', 'farthinker')).toBe('你好，farthinker!');
      return expect(TestModule._t('hello', 'farthinker')).toBe('你好，farthinker!');
    });
  });

}).call(this);
