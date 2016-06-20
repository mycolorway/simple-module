;(function(root, factory) {
  if (typeof module === 'object' && module.exports) {
    module.exports = factory(require('jquery'));
  } else {
    root.SimpleModule = factory(root.jQuery);
  }
}(this, function ($) {
var define, module, exports;
var b = (function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
(function (global){
if (typeof __coverage__ === 'undefined') __coverage__ = {};
(function(_export) {
    if (typeof _export.__coverage__ === 'undefined') {
        _export.__coverage__ = __coverage__;
    }
})(typeof window !== 'undefined' ? window : typeof global !== 'undefined' ? global : this);
if (! __coverage__["/Users/farthinker/Sites/simple-module/src/simple-module.coffee"]) { __coverage__["/Users/farthinker/Sites/simple-module/src/simple-module.coffee"] = {"path":"/Users/farthinker/Sites/simple-module/src/simple-module.coffee","s":{"1":0,"2":0,"3":0,"4":0,"5":0,"6":0,"7":0,"8":0,"9":0,"10":0,"11":0,"12":0,"13":0,"14":0,"15":0,"16":0,"17":0,"18":0,"19":0,"20":0,"21":0,"22":0,"23":0,"24":0,"25":0,"26":0,"27":0},"b":{"1":[0,0],"2":[0,0],"3":[0,0],"4":[0,0]},"f":{"1":0,"2":0,"3":0,"4":0,"5":0,"6":0,"7":0,"8":0,"9":0,"10":0},"fnMap":{"1":{"name":"SimpleModule","line":1,"loc":{"start":{"line":1,"column":6},"end":{"line":1,"column":17}}},"2":{"name":"this","line":8,"loc":{"start":{"line":8,"column":2},"end":{"line":8,"column":18}}},"3":{"name":"this","line":23,"loc":{"start":{"line":23,"column":2},"end":{"line":23,"column":19}}},"4":{"name":"this","line":41,"loc":{"start":{"line":41,"column":2},"end":{"line":41,"column":24}}},"5":{"name":"constructor","line":61,"loc":{"start":{"line":61,"column":2},"end":{"line":61,"column":23}}},"6":{"name":"(anonymous_1)","line":64,"loc":{"start":{"line":64,"column":26},"end":{"line":64,"column":34}}},"7":{"name":"on","line":67,"loc":{"start":{"line":67,"column":2},"end":{"line":67,"column":17}}},"8":{"name":"off","line":70,"loc":{"start":{"line":70,"column":2},"end":{"line":70,"column":18}}},"9":{"name":"trigger","line":73,"loc":{"start":{"line":73,"column":2},"end":{"line":73,"column":22}}},"10":{"name":"one","line":76,"loc":{"start":{"line":76,"column":2},"end":{"line":76,"column":18}}}},"statementMap":{"1":{"start":{"line":1,"column":0},"end":{"line":78,"column":0}},"2":{"start":{"line":9,"column":4},"end":{"line":12,"column":3}},"3":{"start":{"line":10,"column":6},"end":{"line":10,"column":70}},"4":{"start":{"line":12,"column":4},"end":{"line":15,"column":3}},"5":{"start":{"line":13,"column":6},"end":{"line":13,"column":17}},"6":{"start":{"line":15,"column":4},"end":{"line":15,"column":24}},"7":{"start":{"line":16,"column":4},"end":{"line":16,"column":4}},"8":{"start":{"line":24,"column":4},"end":{"line":27,"column":3}},"9":{"start":{"line":25,"column":6},"end":{"line":25,"column":71}},"10":{"start":{"line":27,"column":4},"end":{"line":30,"column":3}},"11":{"start":{"line":28,"column":6},"end":{"line":28,"column":19}},"12":{"start":{"line":30,"column":4},"end":{"line":30,"column":24}},"13":{"start":{"line":31,"column":4},"end":{"line":31,"column":4}},"14":{"start":{"line":42,"column":4},"end":{"line":45,"column":3}},"15":{"start":{"line":43,"column":6},"end":{"line":43,"column":74}},"16":{"start":{"line":45,"column":4},"end":{"line":48,"column":3}},"17":{"start":{"line":46,"column":6},"end":{"line":46,"column":74}},"18":{"start":{"line":48,"column":4},"end":{"line":48,"column":23}},"19":{"start":{"line":49,"column":4},"end":{"line":49,"column":4}},"20":{"start":{"line":62,"column":4},"end":{"line":62,"column":47}},"21":{"start":{"line":64,"column":4},"end":{"line":67,"column":1}},"22":{"start":{"line":65,"column":6},"end":{"line":65,"column":55}},"23":{"start":{"line":68,"column":4},"end":{"line":68,"column":18}},"24":{"start":{"line":71,"column":4},"end":{"line":71,"column":19}},"25":{"start":{"line":74,"column":4},"end":{"line":74,"column":31}},"26":{"start":{"line":77,"column":4},"end":{"line":77,"column":19}},"27":{"start":{"line":79,"column":0},"end":{"line":79,"column":28}}},"branchMap":{"1":{"line":9,"type":"if","locations":[{"start":{"line":9,"column":4},"end":{"line":9,"column":4}},{"start":{"line":9,"column":4},"end":{"line":9,"column":4}}]},"2":{"line":24,"type":"if","locations":[{"start":{"line":24,"column":4},"end":{"line":24,"column":4}},{"start":{"line":24,"column":4},"end":{"line":24,"column":4}}]},"3":{"line":42,"type":"if","locations":[{"start":{"line":42,"column":4},"end":{"line":42,"column":4}},{"start":{"line":42,"column":4},"end":{"line":42,"column":4}}]},"4":{"line":45,"type":"if","locations":[{"start":{"line":45,"column":4},"end":{"line":45,"column":4}},{"start":{"line":45,"column":4},"end":{"line":45,"column":4}}]}}} }(function() {
  var SimpleModule,
    slice = [].slice;

  __coverage__["/Users/farthinker/Sites/simple-module/src/simple-module.coffee"].s[1]++;

  SimpleModule = (function() {
    __coverage__["/Users/farthinker/Sites/simple-module/src/simple-module.coffee"].f[1]++;

    SimpleModule.extend = function(obj) {
      var key, ref, val;
      __coverage__["/Users/farthinker/Sites/simple-module/src/simple-module.coffee"].f[2]++;
      __coverage__["/Users/farthinker/Sites/simple-module/src/simple-module.coffee"].s[2]++;
      if (!(obj && typeof obj === 'object')) {
        __coverage__["/Users/farthinker/Sites/simple-module/src/simple-module.coffee"].b[1][0]++;
        __coverage__["/Users/farthinker/Sites/simple-module/src/simple-module.coffee"].s[3]++;
        throw new Error('SimpleModule.extend: param should be an object');
      } else {
        __coverage__["/Users/farthinker/Sites/simple-module/src/simple-module.coffee"].b[1][1]++;
        void 0;
      }
      __coverage__["/Users/farthinker/Sites/simple-module/src/simple-module.coffee"].s[4]++;
      for (key in obj) {
        val = obj[key];
        if (!(key !== 'included' && key !== 'extended')) {
          continue;
        }
        __coverage__["/Users/farthinker/Sites/simple-module/src/simple-module.coffee"].s[5]++;
        this[key] = val;
      }
      __coverage__["/Users/farthinker/Sites/simple-module/src/simple-module.coffee"].s[6]++;
      if ((ref = obj.extended) != null) {
        ref.call(this);
      }
      __coverage__["/Users/farthinker/Sites/simple-module/src/simple-module.coffee"].s[7]++;
      return this;
    };

    SimpleModule.include = function(obj) {
      var key, ref, val;
      __coverage__["/Users/farthinker/Sites/simple-module/src/simple-module.coffee"].f[3]++;
      __coverage__["/Users/farthinker/Sites/simple-module/src/simple-module.coffee"].s[8]++;
      if (!(obj && typeof obj === 'object')) {
        __coverage__["/Users/farthinker/Sites/simple-module/src/simple-module.coffee"].b[2][0]++;
        __coverage__["/Users/farthinker/Sites/simple-module/src/simple-module.coffee"].s[9]++;
        throw new Error('SimpleModule.include: param should be an object');
      } else {
        __coverage__["/Users/farthinker/Sites/simple-module/src/simple-module.coffee"].b[2][1]++;
        void 0;
      }
      __coverage__["/Users/farthinker/Sites/simple-module/src/simple-module.coffee"].s[10]++;
      for (key in obj) {
        val = obj[key];
        if (!(key !== 'included' && key !== 'extended')) {
          continue;
        }
        __coverage__["/Users/farthinker/Sites/simple-module/src/simple-module.coffee"].s[11]++;
        this.prototype[key] = val;
      }
      __coverage__["/Users/farthinker/Sites/simple-module/src/simple-module.coffee"].s[12]++;
      if ((ref = obj.included) != null) {
        ref.call(this);
      }
      __coverage__["/Users/farthinker/Sites/simple-module/src/simple-module.coffee"].s[13]++;
      return this;
    };

    SimpleModule.plugins = {};

    SimpleModule.plugin = function(name, cls) {
      __coverage__["/Users/farthinker/Sites/simple-module/src/simple-module.coffee"].f[4]++;
      __coverage__["/Users/farthinker/Sites/simple-module/src/simple-module.coffee"].s[14]++;
      if (!(name && typeof name === 'string')) {
        __coverage__["/Users/farthinker/Sites/simple-module/src/simple-module.coffee"].b[3][0]++;
        __coverage__["/Users/farthinker/Sites/simple-module/src/simple-module.coffee"].s[15]++;
        throw new Error('SimpleModule.plugin: first param should be a string');
      } else {
        __coverage__["/Users/farthinker/Sites/simple-module/src/simple-module.coffee"].b[3][1]++;
        void 0;
      }
      __coverage__["/Users/farthinker/Sites/simple-module/src/simple-module.coffee"].s[16]++;
      if (typeof cls !== 'function') {
        __coverage__["/Users/farthinker/Sites/simple-module/src/simple-module.coffee"].b[4][0]++;
        __coverage__["/Users/farthinker/Sites/simple-module/src/simple-module.coffee"].s[17]++;
        throw new Error('SimpleModule.plugin: second param should be a class');
      } else {
        __coverage__["/Users/farthinker/Sites/simple-module/src/simple-module.coffee"].b[4][1]++;
        void 0;
      }
      __coverage__["/Users/farthinker/Sites/simple-module/src/simple-module.coffee"].s[18]++;
      this.plugins[name] = cls;
      __coverage__["/Users/farthinker/Sites/simple-module/src/simple-module.coffee"].s[19]++;
      return this;
    };

    SimpleModule.opts = {
      plugins: []
    };

    SimpleModule.prototype.plugins = {};

    function SimpleModule(opts) {
      __coverage__["/Users/farthinker/Sites/simple-module/src/simple-module.coffee"].f[5]++;
      __coverage__["/Users/farthinker/Sites/simple-module/src/simple-module.coffee"].s[20]++;
      this.opts = $.extend({}, SimpleModule.opts, opts);
      __coverage__["/Users/farthinker/Sites/simple-module/src/simple-module.coffee"].s[21]++;
      this.opts.plugins.forEach((function(_this) {
        return function(name) {
          __coverage__["/Users/farthinker/Sites/simple-module/src/simple-module.coffee"].f[6]++;
          __coverage__["/Users/farthinker/Sites/simple-module/src/simple-module.coffee"].s[22]++;
          return _this.plugins[name] = new SimpleModule.plugins[name](_this);
        };
      })(this));
    }

    SimpleModule.prototype.on = function() {
      var args, ref;
      args = 1 <= arguments.length ? slice.call(arguments, 0) : [];
      __coverage__["/Users/farthinker/Sites/simple-module/src/simple-module.coffee"].f[7]++;
      __coverage__["/Users/farthinker/Sites/simple-module/src/simple-module.coffee"].s[23]++;
      return (ref = $(this)).on.apply(ref, args);
    };

    SimpleModule.prototype.off = function() {
      var args, ref;
      args = 1 <= arguments.length ? slice.call(arguments, 0) : [];
      __coverage__["/Users/farthinker/Sites/simple-module/src/simple-module.coffee"].f[8]++;
      __coverage__["/Users/farthinker/Sites/simple-module/src/simple-module.coffee"].s[24]++;
      return (ref = $(this)).off.apply(ref, args);
    };

    SimpleModule.prototype.trigger = function() {
      var args, ref;
      args = 1 <= arguments.length ? slice.call(arguments, 0) : [];
      __coverage__["/Users/farthinker/Sites/simple-module/src/simple-module.coffee"].f[9]++;
      __coverage__["/Users/farthinker/Sites/simple-module/src/simple-module.coffee"].s[25]++;
      return (ref = $(this)).triggerHandler.apply(ref, args);
    };

    SimpleModule.prototype.one = function() {
      var args, ref;
      args = 1 <= arguments.length ? slice.call(arguments, 0) : [];
      __coverage__["/Users/farthinker/Sites/simple-module/src/simple-module.coffee"].f[10]++;
      __coverage__["/Users/farthinker/Sites/simple-module/src/simple-module.coffee"].s[26]++;
      return (ref = $(this)).one.apply(ref, args);
    };

    return SimpleModule;

  })();

  __coverage__["/Users/farthinker/Sites/simple-module/src/simple-module.coffee"].s[27]++;

  module.exports = SimpleModule;

}).call(this);

}).call(this,typeof global !== "undefined" ? global : typeof self !== "undefined" ? self : typeof window !== "undefined" ? window : {})
},{}]},{},[1]);

return b(1);
}));
