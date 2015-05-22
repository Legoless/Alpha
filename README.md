Alpha
======

[![Stories in Ready](https://badge.waffle.io/legoless/alpha.svg?label=ready&title=Ready)](http://waffle.io/legoless/alpha)
[![Build Status](https://travis-ci.org/Legoless/Alpha.svg)](https://travis-ci.org/legoless/Alpha)
[![Pod Version](http://img.shields.io/cocoapods/v/Alpha.svg?style=flat)](http://cocoadocs.org/docsets/Alpha/)
[![Pod Platform](http://img.shields.io/cocoapods/p/Alpha.svg?style=flat)](http://cocoadocs.org/docsets/Alpha/)
[![Pod License](http://img.shields.io/cocoapods/l/Alpha.svg?style=flat)](http://opensource.org/licenses/BSD-3-Clause)



Alpha is the next generation debugging tool for iOS applications. It started as an unofficial fork from [FLEX](https://github.com/Flipboard/FLEX) (Flipboard Explorer), but continued to be actively developed and grew exponentionally. Many features were added on top of original FLEX:

- Push Notification logging (independent of provider)
- Console logging
- Network logging (based on [PonyDebugger](https://github.com/square/PonyDebugger))
- Bootstrap environment change with [KZBootstrap](https://github.com/krzysztofzablocki/KZBootstrap)
- Screenshot system
- Touches displayed on screen via [Touchpose](https://github.com/toddreed/Touchpose)

Work in progress
- Entire Application State Snapshot
- Status information widgets
- Recording touches and replaying
- Remote connection to app (state)
- Remote debugger

**This is an unofficial fork from the amazing Flipboard guys. It is a big rewrite of FLEX architecture, making it completely extensible, but sadly not backwards compatible with original code.**

*It is currently a work in progress and might be too unstable to be used in real environment yet. Feel free to open GitHub issues.*

![View Hierarchy Exploration](http://engineering.flipboard.com/assets/flex/basic-view-exploration.gif)


## Give Yourself Debugging Superpowers
- Inspect and modify views in the hierarchy.
- See the properties and ivars on any object.
- Dynamically modify many properties and ivars.
- Dynamically call instance and class methods.
- Access any live object via a scan of the heap.
- View the file system within your app's sandbox.
- Explore all classes in your app and linked systems frameworks (public and private).
- Quickly access useful objects such as `[UIApplication sharedApplication]`, the app delegate, the root view controller on the key window, and more.
- Dynamically view and modify `NSUserDefaults` values.

Unlike many other debugging tools, Alpha runs entirely inside your app, so you don't need to be connected to LLDB/Xcode or a different remote debugging server. It works well in the simulator and on physical devices.


Contact
======

Dal Rupnik

- [legoless](https://github.com/legoless) on **GitHub**
- [@thelegoless](https://twitter.com/thelegoless) on **Twitter**
- [dal@unifiedsense.com](mailto:dal@unifiedsense.com)

License
======

**Alpha** is released under the BSD license. See [LICENSE](https://github.com/Legoless/Alpha/blob/master/LICENSE) file for more information.
