![alpha](https://raw.githubusercontent.com/Legoless/Alpha/master/Resources/Logo.png "Alpha Logo")


&nbsp;

[![Issues on Waffle](https://img.shields.io/badge/issues on-Waffle-blue.svg)](http://waffle.io/legoless/alpha)
[![Built by Dominus](https://img.shields.io/badge/built by-Dominus-brightgreen.svg)](http://github.com/legoless/Dominus)
[![Build Status](https://travis-ci.org/Legoless/Alpha.svg)](https://travis-ci.org/legoless/Alpha)
[![Obj-C Code](https://img.shields.io/badge/code in-Objective--C-yellow.svg)](http://github.com/legoless/Alpha)
[![Pod Version](http://img.shields.io/cocoapods/v/Alpha.svg?style=flat)](http://cocoadocs.org/docsets/Alpha/)
[![Pod Platform](http://img.shields.io/cocoapods/p/Alpha.svg?style=flat)](http://cocoadocs.org/docsets/Alpha/)
[![Pod License](http://img.shields.io/cocoapods/l/Alpha.svg?style=flat)](http://opensource.org/licenses/BSD-3-Clause)


### Alpha

Alpha is an idea of the next generation debugging framework for iOS applications. It combines multiple debugging tools built on top of a simple, unified API. It lives entirely in your app sandbox and collects many types of data during your application lifetime. It is very easy to integrate and requires no code changes.

*It is currently a work in progress and might be too unstable to be used in real environment yet. Feel free to open GitHub issues.*

### Features

Features are separated into multiple plugins, which can be enabled or disabled, depending on application requirements.

- Push Notification logging (independent of provider)
- Console logging (ASL)
- Network connection logging
- Environment changes
- Screenshot system
- Touches displayed on screen
- Theme system so it fits into the app.
- Remote connection to app (state, debug)
- Use only specific modules of Alpha
- Inspect and modify views in the hierarchy.
- See the properties and ivars on any object.
- Dynamically modify many properties and ivars.
- Dynamically call instance and class methods.
- Access any live object via a scan of the heap.
- View the file system within your app's sandbox.
- Explore all classes in your app and linked systems frameworks (public and private).
- Dynamically view and modify `NSUserDefaults` values.

Currently work in progress:

**0.3.0**
- *Entire Application State Snapshot*
- *Recording touches and replaying actions*
- *In-app debugger*

### Integration

To use Alpha in your project, all you need to do is add a CocoaPod:

pod 'Alpha'

Alpha supports iOS 8 and up. Not all features are available on all versions.

### Help

- Frequently Asked Questions
- Wiki

### History

Alpha originally started as an unofficial fork from [FLEX](https://github.com/Flipboard/FLEX) (Flipboard Explorer).

### Contributions

This project would not be possible without all the work done by respected community contributors.
Thanks to all the contributors to the following projects:

- [FLEX (Flipboard Explorer)](https://github.com/Flipboard/FLEX)
- [PonyDebugger](https://github.com/square/PonyDebugger)
- [KZBootstrap](https://github.com/krzysztofzablocki/KZBootstrap)
- [Touchpose](https://github.com/toddreed/Touchpose)
- [PINCache](https://github.com/pinterest/PINCache)
- [CKCircleMenuView](https://github.com/JaNd3r/CKCircleMenuView)
- [CWStatusBarNotification](https://github.com/cezarywojcik/CWStatusBarNotification)
- [DTBonjour](https://github.com/Cocoanetics/DTBonjour)
- [Super DB](https://github.com/Shopify/superdb)
- [iConsole](https://github.com/nicklockwood/iConsole)
- [Haystack](https://github.com/legoless/Haystack)
- Many more...

Contact
======

Dal Rupnik

- [legoless](https://github.com/legoless) on **GitHub**
- [@thelegoless](https://twitter.com/thelegoless) on **Twitter**
- [dal@unifiedsense.com](mailto:dal@unifiedsense.com)

License
======

**Alpha** is released under the MIT license. See [LICENSE](https://github.com/Legoless/Alpha/blob/master/LICENSE) file for more information.
