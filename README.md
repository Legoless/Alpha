![alpha](https://raw.githubusercontent.com/Legoless/Alpha/master/Resources/Logo.png "Alpha Logo")

&nbsp;

[![Issues on Waffle](https://img.shields.io/badge/issues on-Waffle-blue.svg)](http://waffle.io/legoless/alpha)
[![Built by Dominus](https://img.shields.io/badge/built by-Dominus-brightgreen.svg)](http://github.com/legoless/Dominus)
[![Build Status](https://travis-ci.org/Legoless/Alpha.svg)](https://travis-ci.org/legoless/Alpha)
[![Obj-C Code](https://img.shields.io/badge/code in-Objective--C-yellow.svg)](http://github.com/legoless/Alpha)
[![Pod Version](http://img.shields.io/cocoapods/v/Alpha.svg?style=flat)](http://cocoadocs.org/docsets/Alpha/)
[![Pod Platform](http://img.shields.io/cocoapods/p/Alpha.svg?style=flat)](http://cocoadocs.org/docsets/Alpha/)
[![Pod License](http://img.shields.io/cocoapods/l/Alpha.svg?style=flat)](http://opensource.org/licenses/MIT)


**Alpha** is an idea of the next generation debugging framework for iOS applications. It combines multiple debugging tools built on top of a **simple, unified API**. It lives entirely in your app sandbox and collects information during your application lifetime. It is very easy to integrate and requires **no code changes**.

*It is currently a work in progress and might be too unstable to be used in real environment yet. Feel free to open GitHub issues.*

![intro](https://raw.githubusercontent.com/Legoless/Alpha/master/Resources/Intro.gif "Alpha Intro")

# Features

Features are separated into multiple plugins, which can be enabled or disabled, depending on application requirements.

- **Bonjour** - contains a simple Bonjour server allowing Alpha to work over local Wi-Fi network.
- **Bootstrap** - checks for [KZBootstrap](https://github.com/krzysztofzablocki/KZBootstrap) environments and allows modifying them in real-time.
- **Console** - displays console logs (logged by NSLog) inside the application.
- **Event** - logs and displays application wide events such as background state transitions and view controller appearances.
- **File** - allows browsing the sandboxed file system and previewing common file types, such as images, videos and text.
- **Global** - information plugin displays linked frameworks, libraries and classes.
- **Heap** - allows inspection of active object instances on ther heap and helps with debugging memory errors.
- **Interface** - plugin is a specific plugin and is required to display Alpha menu interface and actions.
- **Network** - logs network connections made using `NSURLSession` and `NSURLConnection` API's.
- **Notification** - displays scheduled and fired local notifications, received push notifications and notification permissions.
- **Object** - allows for inspection of any class or object in the application, including `NSUserDefaults`, arrays and dictionaries.
- **Remote** - plugin allows connecting to Alpha on another device.
- **Screenshot** - plugin allows taking screenshots of the application with a single action.
- **State** - allows inspecting the device state and settings, such as locale, time and available memory.
- **Touch** - plugin displays touches on screen when activated.
- **View** - allows view hierarchy manipulation and inspection in real-time.

Currently work in progress:

**0.3.0**
- *Entire Application State Snapshot*
- *Recording touches and replaying actions*
- *In-app debugger*

### Themes

Alpha is meant to work with any application, but the default dark theme does not always fit best with the application color scheme.

To better fit with various applications Alpha has theme support, which allows you to choose the color palette you wish to display Alpha in.

![Default](https://raw.githubusercontent.com/Legoless/Alpha/master/Resources/Default_Theme.png "Default Theme")
![Formentera](https://raw.githubusercontent.com/Legoless/Alpha/master/Resources/Formentera_Theme.png "Formentera Theme")
![Notio](https://raw.githubusercontent.com/Legoless/Alpha/master/Resources/Notio_Theme.png "Notio Theme")

There are **6 themes** available:
- [Default](https://raw.githubusercontent.com/Legoless/Alpha/master/Resources/Default_Theme.png) (first picture)
- [Formentera](https://raw.githubusercontent.com/Legoless/Alpha/master/Resources/Formentera_Theme.png) (second picture)
- [Notio](https://raw.githubusercontent.com/Legoless/Alpha/master/Resources/Notio_Theme.png) (third picture)
- [Alizarin](https://raw.githubusercontent.com/Legoless/Alpha/master/Resources/Alizarin_Theme.png) - *by [Vikilas](http://vikilas.com)*
- [Amethyst](https://raw.githubusercontent.com/Legoless/Alpha/master/Resources/Amethyst_Theme.png) - *by [Vikilas](http://vikilas.com)*
- [Green Sea](https://raw.githubusercontent.com/Legoless/Alpha/master/Resources/GreenSea_Theme.png) - *by [Vikilas](http://vikilas.com)*

If is also possible to create your own theme and use it in Alpha system.

*Read more on [Themes]().*

### Triggers

Triggers are a way to activate Alpha interface from your application. By default Alpha provides two triggers:

- **Shake Trigger** - Activates when device is shaken two times in less than 5 seconds.
- **Tap Trigger** - Activates when 3 fingers are pressed for 3 seconds anywhere in the application.

Both triggers are activated by default. Alternatively you can implement your own trigger or use the manual trigger.

*Read more on [Triggers]().*

# Integration

To use Alpha in your project, all you need to do is add a **CocoaPods** library:

```ruby
pod 'Alpha'
```
This automatically includes all plugins and features. To avoid clashes with certain libraries used in application, all Alpha classes use `ALPHA` prefix. The recommended way is to ignore Alpha version and always use the latest version, to ensure best stability possible. You can also pick the plugins to integrate manually.

```ruby
pod 'Alpha/Bonjour'
pod 'Alpha/Interface'
pod 'Alpha/State'
```

*Alpha supports iOS 8 and up. Not all features are available on all versions.*

*Read more on [Integration]().*

# The Story

*Alpha originally started as an unofficial fork from [FLEX](https://github.com/Flipboard/FLEX) (Flipboard Explorer). It began with a desire to add multiple features to FLEX, but looking at it more and more, it was obvious that many architectural changes were required to support remote clients. Those kind of changes are the hardest to merge into original repository without breaking multiple features, it was obvious that it fits more to create a separate repository.*

*So Alpha was converted into a separate repository and work began on top of that. Many features were added and there are many architectural changes under the hood. Alpha is now not a separate tool, but a framework that offers a full API. Features from tools are now working on top of plugin API, which allows dynamic loading and incredible extensibility.*

# Documentation

The entire Alpha documentation is available on [Wiki]() and on [CocoaDocs]().

- Read [Getting Started]().
- Browse [Architecture]().
- Go through [Frequently Asked Questions](https://github.com/Legoless/Alpha/wiki/Frequently-Asked-Questions).

# Contributions

To contribute to Alpha, please open pull requests. We warmly welcome any feature implementations or improvements, bug fixes, documentation or anything else you can think of.

# Thanks

This project would not be possible without all the work done by respected community contributors.
Thanks to all contributors of the following projects:

- [**FLEX (Flipboard Explorer)**](https://github.com/Flipboard/FLEX)
- [CKCircleMenuView](https://github.com/JaNd3r/CKCircleMenuView)
- [CWStatusBarNotification](https://github.com/cezarywojcik/CWStatusBarNotification)
- [DTBonjour](https://github.com/Cocoanetics/DTBonjour)
- [Haystack](https://github.com/legoless/Haystack)
- [iConsole](https://github.com/nicklockwood/iConsole)
- [KZBootstrap](https://github.com/krzysztofzablocki/KZBootstrap)
- [PonyDebugger](https://github.com/square/PonyDebugger)
- [PINCache](https://github.com/pinterest/PINCache)
- [Super DB](https://github.com/Shopify/superdb)
- [Touchpose](https://github.com/toddreed/Touchpose)
- Many more...

Contact
======

Dal Rupnik

- [legoless](https://github.com/legoless) on **GitHub**
- [@thelegoless](https://twitter.com/thelegoless) on **Twitter**
- [dal@unifiedsense.com](mailto:dal@unifiedsense.com)

License
======

**Alpha** is released under the **MIT** license. See [LICENSE](https://github.com/Legoless/Alpha/blob/master/LICENSE) file for more information.
