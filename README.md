# Simple Module

[![Latest Version](https://img.shields.io/npm/v/simple-module.svg)](https://www.npmjs.com/package/simple-module)
[![Build Status](https://img.shields.io/travis/mycolorway/simple-module.svg)](https://travis-ci.org/mycolorway/simple-module)
[![Coveralls](https://img.shields.io/coveralls/mycolorway/simple-module.svg)](https://coveralls.io/github/mycolorway/simple-module)
[![David](https://img.shields.io/david/mycolorway/simple-module.svg)](https://david-dm.org/mycolorway/simple-module)
[![David](https://img.shields.io/david/dev/mycolorway/simple-module.svg)](https://david-dm.org/mycolorway/simple-module#info=devDependencies)
[![Gitter](https://img.shields.io/gitter/room/nwjs/nw.js.svg)](https://gitter.im/mycolorway/simple-module)

SimpleModule is a simple base class providing some necessary features to make its subclasses extendable.

## Features

#### Events

SimpleModule delegate events mothods to jQuery object:

```js
let module = new SimpleModule();

// bind namespace event
module.on('customEvent.test', function(data) {
  console.log(data);
});
// equivalent to
$(module).on('customEvent.test', function(data) {
  console.log(data);
});

// trigger a namespace event
module.trigger('customEvent.test', 'test');
// equivalent to
$(module).trigger('customEvent.test', 'test');
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

## Issues

If you have issues about this module, please consider discussing it on [Gitter channel](https://gitter.im/mycolorway/simple-module) first.

If you confirm the issue is indeed a bug, please browse the [issues page](https://github.com/mycolorway/simple-module/issues) for existing issues describing the same problem before creating new issue.

When you create new issue, please describe it with detailed information, for example, demo code, error stacks, screenshots etc. Issues without enough debug information will probably be closed.

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

* Put your [personal API tokens](https://github.com/blog/1509-personal-api-tokens) in `/.token.json`, which is required by the build scripts to request [Github API](https://developer.github.com/v3/) for creating new release:

```json
{
  "github": "[your github personal access token]"
}
```

Now you can run `gulp publish` task, which will do these work for you:

* Get version number from `CHANGELOG.md` and bump it into `package.json` and `bower.json`.
* Get release information from `CHANGELOG.md` and request Github API to create new release.

If everything goes fine, you can see your release at [https://github.com/mycolorway/simple-module/releases](https://github.com/mycolorway/simple-module/releases). At the End you can publish new version to npm with the command:

```bash
npm publish
```

Please be careful with the last step, because you cannot delete or republish a version on npm.
