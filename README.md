![alpha](https://raw.githubusercontent.com/Legoless/Alpha/master/Resources/Logo.png "Alpha Logo")

### Alpha

[![Issues on Waffle](https://img.shields.io/badge/issues on-Waffle-blue.svg)](http://waffle.io/legoless/alpha)
[![Built by Dominus](https://img.shields.io/badge/built by-Dominus-brightgreen.svg)](http://github.com/legoless/Dominus)
[![Build Status](https://travis-ci.org/Legoless/Alpha.svg)](https://travis-ci.org/legoless/Alpha)
[![Obj-C Code](https://img.shields.io/badge/code in-Objective--C-yellow.svg)](http://github.com/legoless/Alpha)
[![Pod Version](http://img.shields.io/cocoapods/v/Alpha.svg?style=flat)](http://cocoadocs.org/docsets/Alpha/)
[![Pod Platform](http://img.shields.io/cocoapods/p/Alpha.svg?style=flat)](http://cocoadocs.org/docsets/Alpha/)
[![Pod License](http://img.shields.io/cocoapods/l/Alpha.svg?style=flat)](http://opensource.org/licenses/BSD-3-Clause)



Alpha is the next generation debugging system for iOS applications. It started as an unofficial fork from [FLEX](https://github.com/Flipboard/FLEX) (Flipboard Explorer), but continued to be actively developed and grew exponentionally. Complete feature set for Alpha:

- Push Notification logging (independent of provider)
- Console logging (ASL)
- Network logging
- Environment changes
- Screenshot system
- Touches displayed on screen
- Theme system
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


**This is an unofficial fork from the amazing Flipboard guys. It is a big rewrite of FLEX architecture, making it completely extensible, but sadly not backwards compatible with original code.**

*It is currently a work in progress and might be too unstable to be used in real environment yet. Feel free to open GitHub issues.*

![View Hierarchy Exploration](http://engineering.flipboard.com/assets/flex/basic-view-exploration.gif)


## Contributions

Thanks to all the contributors to the following projects:

- [FLEX (Flipboard Explorer)](https://github.com/Flipboard/FLEX)
- [PonyDebugger](https://github.com/square/PonyDebugger)
- [KZBootstrap](https://github.com/krzysztofzablocki/KZBootstrap)
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

**Alpha** is released under the BSD license. See [LICENSE](https://github.com/Legoless/Alpha/blob/master/LICENSE) file for more information.
