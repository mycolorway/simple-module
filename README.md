# Simple Module

[![Latest Version](https://img.shields.io/npm/v/simple-module.svg)](https://www.npmjs.com/package/simple-module)
[![Build Status](https://img.shields.io/travis/mycolorway/simple-module.svg)](https://travis-ci.org/mycolorway/simple-module)
[![David](https://img.shields.io/david/mycolorway/simple-module.svg)](https://david-dm.org/mycolorway/simple-module)
[![David](https://img.shields.io/david/dev/mycolorway/simple-module.svg)](https://david-dm.org/mycolorway/simple-module#info=devDependencies)
[![Gitter](https://img.shields.io/gitter/room/nwjs/nw.js.svg)](https://gitter.im/mycolorway/simple-module)

SimpleModule is a simple base class providing some necessary features to make its subclasses extendable.

## Features

#### Event Emitter

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

#### Mixins

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

#### Plugins

Register a plugin on SimpleModule:

```js
class TestPlugin extends SimpleModule {
  constructor(module) {
    super()
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

Install via bower:

```bash
bower install --save simple-module
```

## Submitting Issues

If have issues while using this module, please consider discussing it on [Gitter channel](https://gitter.im/mycolorway/simple-module) first.

If you confirm the issue is indeed a bug, you can browse the [issues page](https://github.com/mycolorway/simple-module/issues) for existing issues describing the same problem.

If you found nothing on issues page, please create an new issue with detailed debug information, for example, reproduce procedure, error stacks, screenshots etc. Issues without enough debug information will probably be closed.

## Development

Clone repository from github:

```bash
git clone https://github.com/mycolorway/simple-module.git
```

Install npm dependencies:

```bash
npm install
```

Run default gulp task to build project, which will compile source files, run test and watch file changes for you:

```bash
gulp
```

Now, you are ready to go.

## Publish

If you want to publish new version to npm and bower, please make sure all tests have passed before you publish new version, and you need do these preparations:

* Add new release information in `CHANGELOG.md`. The format of markdown contents will matter, because build scripts will get version and release content from this file by regular expression. You can follow the format of the older release information.

* Run `gulp` default task, which will get version number from `CHANGELOG.md` and bump it into `package.json` and `bower.json`, before you push the commit for new version.

* Put your [personal API tokens](https://github.com/blog/1509-personal-api-tokens) in `/.token.json`, which is required by build scripts to request [Github API](https://developer.github.com/v3/):

```json
{
  "github": "[your github personal access token]"
}
```

Now you can run `gulp publish` task, which will do these work for you:

* Generate the static doc site and push it to `gh-pages` branch.
* Get release information from `CHANGELOG.md` and request Github API to create new release.

If everything goes fine, you can publish new version to npm at the end:

```bash
npm publish
```
