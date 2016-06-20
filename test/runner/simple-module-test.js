(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
var expect,
  extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  hasProp = {}.hasOwnProperty;

expect = chai.expect;

describe('SimpleModule', function() {
  var TestPlugin;
  TestPlugin = (function(superClass) {
    extend(TestPlugin, superClass);

    function TestPlugin(module1) {
      this.module = module1;
      TestPlugin.__super__.constructor.call(this);
      this.test = true;
    }

    TestPlugin.prototype.start = function() {
      return this.started = true;
    };

    return TestPlugin;

  })(SimpleModule);
  it('should support custom events', function() {
    var callCount, listener, module;
    module = new SimpleModule();
    callCount = 0;
    listener = function() {
      return callCount += 1;
    };
    module.on('customEvent', listener);
    module.trigger('customEvent');
    expect(callCount).to.be.equal(1);
    module.off('customEvent');
    module.trigger('customEvent');
    expect(callCount).to.be.equal(1);
    module.on('customEvent', listener);
    module.trigger('customEvent');
    expect(callCount).to.be.equal(2);
    module.off('customEvent', listener);
    module.trigger('customEvent');
    expect(callCount).to.be.equal(2);
    module.one('customEvent', listener);
    module.trigger('customEvent');
    module.trigger('customEvent');
    return expect(callCount).to.be.equal(3);
  });
  it('can extend properties', function() {
    var extendWithWrongArgs;
    extendWithWrongArgs = function() {
      return SimpleModule.extend('test');
    };
    expect(extendWithWrongArgs).to["throw"](/param should be an object/);
    SimpleModule.extend({
      classProperty: true
    });
    return expect(SimpleModule.classProperty).to.be.equal(true);
  });
  it('can include prototype properties', function() {
    var includeWithWrongArgs, module;
    includeWithWrongArgs = function() {
      return SimpleModule.include('test');
    };
    expect(includeWithWrongArgs).to["throw"](/param should be an object/);
    SimpleModule.include({
      prototypeProperty: true
    });
    module = new SimpleModule();
    expect(SimpleModule.prototype.prototypeProperty).to.be.equal(true);
    return expect(module.prototypeProperty).to.be.equal(true);
  });
  it('can register plugin', function() {
    var registerWithoutClass, registerWithoutName;
    registerWithoutName = function() {
      return SimpleModule.plugin();
    };
    expect(registerWithoutName).to["throw"](/first param should be a string/);
    expect(SimpleModule.plugins.testPlugin).to.be.undefined;
    registerWithoutClass = function() {
      return SimpleModule.plugin('testPlugin');
    };
    expect(registerWithoutClass).to["throw"](/second param should be a class/);
    expect(SimpleModule.plugins.testPlugin).to.be.undefined;
    SimpleModule.plugin('testPlugin', TestPlugin);
    return expect(SimpleModule.plugins.testPlugin).to.be.equal(TestPlugin);
  });
  it('can create instance with plugin', function() {
    var module;
    SimpleModule.plugin('testPlugin', TestPlugin);
    module = new SimpleModule({
      plugins: ['testPlugin']
    });
    expect(module.plugins.testPlugin instanceof TestPlugin).to.be.equal(true);
    expect(module.plugins.testPlugin.test).to.be.equal(true);
    module.plugins.testPlugin.start();
    return expect(module.plugins.testPlugin.started).to.be.equal(true);
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
        $.extend(this.opts, ModuleA.opts, opts);
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
        $.extend(this.opts, ModuleB.opts, opts);
      }

      return ModuleB;

    })(ModuleA);
    moduleB = new ModuleB();
    moduleA = new ModuleA();
    module = new SimpleModule();
    moduleX = new ModuleB({
      name: 'X'
    });
    expect(moduleB.opts.name).to.be.equal('B');
    expect(moduleA.opts.name).to.be.equal('A');
    expect(module.opts.name).to.be.undefined;
    return expect(moduleX.opts.name).to.be.equal('X');
  });
});

},{}]},{},[1]);
