(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  describe('SimpleModule', function() {
    it('should inherit from EventEmitter', function() {
      var module, obj;
      module = new SimpleModule();
      obj = {
        listener: function() {
          return console.log('customEvent triggered');
        }
      };
      spyOn(obj, 'listener');
      module.on('customEvent', obj.listener);
      module.trigger('customEvent');
      return expect(obj.listener).toHaveBeenCalled();
    });
    it('should support mixins', function() {
      var module;
      SimpleModule.extend({
        classProperty: true
      });
      SimpleModule.include({
        prototypeProperty: true
      });
      module = new SimpleModule();
      expect(SimpleModule.classProperty).toBe(true);
      expect(SimpleModule.prototype.prototypeProperty).toBe(true);
      return expect(module.prototypeProperty).toBe(true);
    });
    it('can have plugins', function() {
      var TestPlugin, module;
      TestPlugin = (function(superClass) {
        extend(TestPlugin, superClass);

        function TestPlugin(module1) {
          this.module = module1;
          TestPlugin.__super__.constructor.call(this);
          this.test = true;
        }

        TestPlugin.prototype.start = function() {
          return console.log('start test');
        };

        return TestPlugin;

      })(SimpleModule);
      SimpleModule.plugin('testPlugin', TestPlugin);
      expect(SimpleModule.plugins.testPlugin).toBe(TestPlugin);
      module = new SimpleModule({
        plugins: ['testPlugin']
      });
      expect(module.plugins.testPlugin instanceof TestPlugin).toBe(true);
      expect(module.plugins.testPlugin.test).toBe(true);
      spyOn(module.plugins.testPlugin, 'start');
      module.plugins.testPlugin.start();
      return expect(module.plugins.testPlugin.start).toHaveBeenCalled();
    });
    return it('should let subclasses override default options', function() {
      var ModuleA, ModuleB, module, moduleA, moduleB, moduleX;
      ModuleA = (function(superClass) {
        extend(ModuleA, superClass);

        ModuleA.opts = {
          name: 'A'
        };

        function ModuleA(opts) {
          ModuleA.__super__.constructor.call(this);
          _.extend(this.opts, ModuleA.opts, opts);
        }

        return ModuleA;

      })(SimpleModule);
      ModuleB = (function(superClass) {
        extend(ModuleB, superClass);

        ModuleB.opts = {
          name: 'B'
        };

        function ModuleB(opts) {
          ModuleB.__super__.constructor.call(this);
          _.extend(this.opts, ModuleB.opts, opts);
        }

        return ModuleB;

      })(ModuleA);
      moduleB = new ModuleB();
      moduleA = new ModuleA();
      module = new SimpleModule();
      moduleX = new ModuleB({
        name: 'X'
      });
      expect(moduleB.opts.name).toBe('B');
      expect(moduleA.opts.name).toBe('A');
      expect(module.opts.name).toBeUndefined();
      return expect(moduleX.opts.name).toBe('X');
    });
  });

}).call(this);
