(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  describe('Simple Module', function() {
    var TestModule;
    TestModule = (function(_super) {
      __extends(TestModule, _super);

      function TestModule() {
        return TestModule.__super__.constructor.apply(this, arguments);
      }

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
    return it('can connect other class', function() {
      var TestPlugin, testModule, _ref;
      TestPlugin = (function(_super) {
        __extends(TestPlugin, _super);

        function TestPlugin() {
          return TestPlugin.__super__.constructor.apply(this, arguments);
        }

        TestModule.connect(TestPlugin);

        return TestPlugin;

      })(SimpleModule);
      testModule = new TestModule();
      expect((_ref = testModule.testPlugin) != null ? _ref.constructor : void 0).toBeDefined();
      return expect(testModule.testPlugin.constructor).toBe(TestPlugin);
    });
  });

}).call(this);
