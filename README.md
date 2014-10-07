Simple Module
=========

Simple Module是一个CoffeeScript抽象类，彩程的前端UI库都基于这个抽象类来构建。

依赖jQuery 2.0+，支持：IE10+、Firefox、Chrome、Safari。

SimpleModule类可以为组件提供这些功能：

####动态扩展

`SimpleModule.extend` 可以给组件动态的添加类属性和类方法。

`SimpleModule.include` 可以给组件动态的添加原型属性和原型方法。

`SimpleModule.connect` 可以给组件挂载插件和扩展。

#### 自定义事件

基于jQuery的自定义事件的实现了这些事件接口：

`module.on 'type', callback` 绑定事件

`module.one 'type', callback` 绑定事件，并在第一次触发之后自动解除绑定

`module.off 'type'` 解绑事件

`module.trigger 'type', [args]` 触发自定义事件

`module.triggerHandler 'type', [args]` 触发自定义事件，并且返回最后一个callback的返回值

#### 简单的本地化支持

`Module.i18n` 对象用来存放本地化资源（键值对），例如：

```coffee
Module.i18n =
  'zh-Cn':
    hello: '你好，%s'
  'en':
    hello: 'Hi, %s'
```

`Module.locale` 用来设置当前的本地化语言，例如：

```coffee
Module.locale = 'zh-CN'
```

`module._t(key, args..)` 可以用来获取translation字符串，例如：

```coffee
@_t('hello', 'farthinker') # Hi, farthinker
```

SimpleModule只提供了最简单的本地化支持，一些本地化内容比较复杂的组件还是推荐使用像[i18next](http://i18next.com/)这样功能完整的本地化库。

