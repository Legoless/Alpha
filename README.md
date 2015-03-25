# Alpha

Alpha is the next generation debugging tool for iOS applications. It started as an unofficial fork from FLEX (Flipboard Explorer), but continued to be actively developed and grow exponentionally. Many features were added on top of original FLEX:

- Push Notification logging (independent of provider)
- Console logging
- Network logging (based on PonyDebugger)
- Screenshot management
- Entire Application State Snapshot
- Status information widgets
- Recording touches and replaying
- Touches displayed on screen via Touchpose
- Remote connection to app
- Remote debugging
- Bootstrap environment change with [KZBootstrap](https://github.com/krzysztofzablocki/KZBootstrap)

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

Unlike many other debugging tools, FLEX runs entirely inside your app, so you don't need to be connected to LLDB/Xcode or a different remote debugging server. It works well in the simulator and on physical devices.

## TODO
- Improved file type detection and display in the file browser
- Add new NSUserDefaults key/value pairs on the fly
- Rewrite network logging to support Async requests

Have a question or suggestion for FLEX? Contact [@ryanolsonk](https://twitter.com/ryanolsonk) on twitter.
