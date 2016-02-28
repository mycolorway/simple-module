/**
 * simple-module v3.0.0
 * http://mycolorway.github.io/simple-module
 * 
 * Copyright Mycolorway Design
 * Released under the MIT license
 * http://mycolorway.github.io/simple-module/license
 * 
 * Date: 2/29/2016, 12:06:12 AM
 */

var EventEmitter, SimpleModule, _,
  extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  hasProp = {}.hasOwnProperty,
  slice = [].slice;

EventEmitter = require('eventemitter2');

_ = require('lodash');

SimpleModule = (function(superClass) {
  extend(SimpleModule, superClass);

  SimpleModule.extend = function(obj) {
    var key, ref, val;
    if (!(obj && typeof obj === 'object')) {
      throw new Error('SimpleModule.extend: param should be an object');
      return;
    }
    for (key in obj) {
      val = obj[key];
      if (key !== 'included' && key !== 'extended') {
        this[key] = val;
      }
    }
    if ((ref = obj.extended) != null) {
      ref.call(this);
    }
    return this;
  };

  SimpleModule.include = function(obj) {
    var key, ref, val;
    if (!(obj && typeof obj === 'object')) {
      throw new Error('SimpleModule.include: param should be an object');
      return;
    }
    for (key in obj) {
      val = obj[key];
      if (key !== 'included' && key !== 'extended') {
        this.prototype[key] = val;
      }
    }
    if ((ref = obj.included) != null) {
      ref.call(this);
    }
    return this;
  };

  SimpleModule.plugins = {};

  SimpleModule.plugin = function(name, cls) {
    if (!(name && typeof name === 'string')) {
      throw new Error('SimpleModule.plugin: first param should be a string');
      return;
    }
    if (typeof cls !== 'function') {
      throw new Error('SimpleModule.plugin: second param should be a class reference');
      return;
    }
    return this.plugins[name] = cls;
  };

  SimpleModule.prototype.opts = {
    plugins: []
  };

  SimpleModule.prototype.plugins = {};

  function SimpleModule(opts) {
    _.extend(this.opts, opts);
    this.opts.plugins.forEach((function(_this) {
      return function(name) {
        return _this.plugins[name] = new _this.constructor.plugins[name](_this);
      };
    })(this));
    this;
  }

  SimpleModule.prototype.one = function() {
    var args;
    args = 1 <= arguments.length ? slice.call(arguments, 0) : [];
    return this.once.apply(this, args);
  };

  SimpleModule.prototype.trigger = function() {
    var args;
    args = 1 <= arguments.length ? slice.call(arguments, 0) : [];
    return this.emit.apply(this, args);
  };

  SimpleModule.prototype.triggerAsync = function() {
    var args;
    args = 1 <= arguments.length ? slice.call(arguments, 0) : [];
    return this.emitAsync.apply(this, args);
  };

  return SimpleModule;

})(EventEmitter);

module.exports = SimpleModule;
