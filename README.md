## Introduction

SimpleModule is a simple base class providing these features for subclasses:

### Event Emitter

SimpleModule inherits from [EventEmitter2](https://github.com/asyncly/EventEmitter2) which is an advanced version of Node.js default [EventEmitter](https://nodejs.org/api/events.html). EventEmitter2 provides event namespaces and wildcards:

```js
let module = new SimpleModule();

// bind namespace event
module.on('customEvent.test', function(data) {
  console.log(data);
});

// module.one is alias of module.once
module.one('customEvent.*', function(data) {
  console.log(data);
});

// module.trigger is alias of module.emit
module.trigger('customEvent', 'data string');
module.emit('customEvent', 'data string');
```

### Mixins

Add class properties and methods to SimpleModule:

```js
var testMixins = {
  classProperty: true,
  classMethod: function() {}
};

SimpleModule.extend(testMixins);
```

Add instance properties and methods to SimpleModule:

```js
var testMixins = {
  instanceProperty: true,
  instanceMethod: function() {}
};

SimpleModule.include(testMixins);
```

### Plugins

Register a plugin on SimpleModule:

```js
class TestPlugin extends SimpleModule {
  constructor(module) {
    this.module = module;
    this.test = true;
  }
}

SimpleModule.plugin('testPlugin', TestPlugin);
```

Then pass the plugin name to options while creating instance:

```js
let module = new SimpleModule({
  plugins: ['testPlugin']
});
console.log(module.plugins.testPlugin.test); // true
```

## Installation

Install via npm:

```bash
npm install --save simple-module
```

Or install via bower:

```bash
bower install --save simple-module
```

Or download source code from [Releases](https://github.com/mycolorway/simple-module/releases) and reference bundled file in you project:

```html
<script src="[path]/simple-module-bundled.js.min"></script>
```
