Purpose
--------------

FXKeychain is a lightweight wrapper around the Apple keychain APIs that exposes the commonly used functionality whilst hiding the horrific complexity and ugly interface of the underlying APIs.

FXKeychain treats the keychain like a simple dictionary that you can set and get values from. For most purposes you can get by using the defaultKeychain, however it is also possible to create new keychain instances if you wish to namespace your keychain by service, or share values between apps using an accessGroup.


Supported iOS & SDK Versions
-----------------------------

* Supported build target - iOS 8.0 / Mac OS 10.9 (Xcode 6.0, Apple LLVM compiler 6.0)
* Earliest supported deployment target - iOS 5.0 / Mac OS 10.7
* Earliest compatible deployment target - iOS 4.3 / Mac OS 10.6

NOTE: 'Supported' means that the library has been tested with this version. 'Compatible' means that the library should work on this iOS version (i.e. it doesn't rely on any unavailable SDK features) but is no longer being tested for compatibility and may require tweaking or bug fixes to run correctly.


ARC Compatibility
------------------

FXKeychain requires ARC. If you wish to use FXKeychain in a non-ARC project, just add the -fobjc-arc compiler flag to the FXKeychain.m class. To do this, go to the Build Phases tab in your target settings, open the Compile Sources group, double-click FXKeychain.m in the list and type -fobjc-arc into the popover.

If you wish to convert your whole project to ARC, comment out the #error line in FXKeychain.m, then run the Edit > Refactor > Convert to Objective-C ARC... tool in Xcode and make sure all files that you wish to use ARC for (including FXKeychain.m) are checked.


Installation
---------------

To use FXKeychain, just drag the class files into your project and add the Security framework. You can use the [FXKeychain defaultKeychain] shared instance, or create new instance as and when you need them.


Thread Safety
-----------------

1. It is safe to use a given FXKeychain instance from any thread.
2. Use a single FXKeychain instance per thread, do not access a single instance from more than one thread concurrently (including the default instance).
3. If you have multiple FKKeychain instances that point to the same service, it is safe to read their values from multiple threads concurrently, but you should not attempt to write to the same key from two different threads concurrently.


Security
------------

Caution is advised when storing and retrieving non-string objects from the keychain. On iOS, the keychain is sandboxed to a single app or to a group of apps shared by a single developer. But on Mac OS, any app can read or write to any entry in the keychain. This offers the potential for a malicious app to attempt to manipulate the behaviour of another by changing its keychain data.

Version 1.2 and earlier of FXKeychain allowed arbitrary classes to be stored in the keychain using NSCoding. This feature was removed in 1.3 to mitigate the risk that an app might change the encoded classes in your app's keychain in order to get it to load and run code that it isn't supposed to. In version 1.5, the feature has been restored but is controlled by the FXKEYCHAIN_USE_NSCODING macro. It is enabld by default on iOS (which is sandboxed and therefore relatively safe) and disabled by default on Mac OS (which isn't).

Code injection is a low risk on iOS (unless the device is jailbroken). On Mac OS, using version 1.3 or above should protect you from code injection, as only plist-compatible classes are now supported by default, which cannot easily be used in a malicious way. It is still recommended however that you verify that the data being loaded from the keychain  matches the type and structure that you are expecting in order to protect against malicious or mischevious tinkering with the data that might crash your app or cause it to behave strangely.


Properties
------------------
    
FXKeychain has the following properties:
        
    @property (nonatomic, copy, readonly) NSString *service;
    
The service property is used to distinguish between multiple apps or services on a given device or within the same app. On Mac OS and the iOS simulator, services are shared between apps, so it's a good idea to use something unique for the service, such as the application bundle ID, or the same value as the accessGroup if you wish to share a service between multiple apps. The service value cannot be changed after the keychain has been created.
    
    @property (nonatomic, copy, readonly) NSString *accessGroup;

The accessGroup property is used for sharing a keychain between multiple iOS apps from the same vendor. See Apple's documentation for acceptable values to use for the accessGroup. Leave this value nil if you do not intend to share the keychain between apps. On Mac OS, the keychain is already shared between apps, so this property has no effect. The accessGroup cannot be changed after the keychain has been created.

    @property (nonatomic, assign) FXKeychainAccess accessibility;

The accessibility property is used for controlling access to the keychain when the device is locked. See FXKeychainAccess values description below for possible values. On Mac OS, prior to 10.9 (Mavericks) this property has no effect. Unlike the other attributes, the accessibility property can be changed at any time, however, changes will only affect keys that are set subsequent to the change; existing keys in the keychain will not be affected unless they are re-written.


Methods
----------------

    + (instancetype)defaultKeychain;
    
This method returns a shared default keychain instance, which uses the app's bundle ID for the service to avoid namespace collisions with other apps on Mac OS or the iOS simulator.
    
    - (id)initWithService:(NSString *)service
              accessGroup:(NSString *)accessGroup;

    - (id)initWithService:(NSString *)service
              accessGroup:(NSString *)accessGroup
            accessibility:(FXKeychainAccess)accessibility;

This method creates a new FXKeychain instance with the specified parameters. Each FXKeychain can contain as many key/value pairs as you want, so you probably only need a single FXKeychain per application. Each FXKeychain is uniquely identified by the service parameter; see the Properties description for how to use this. You can specify nil for the service, in which case it will act as "wildcard" selector and calls to objectForKey: will return the first value found within any service stored in the keychain. The accessGroup parameter is used for setting up shared keychains that can be accessed by multiple different apps; leave this as nil if you do not require that functionality. The optional accessibility property controls whether the keychain items can be accessed if the app is launched in the background when the device is locked (see FXKeychainAccess values description below for details).
    
    - (BOOL)setObject:(id)object forKey:(id)key;
    - (BOOL)setObject:(id)object forKeyedSubscript:(id)key;
    
These methods will save the specified object in the keychain. Any plist-compatible object (NSDictionary, NSArray, NSString, NSNumber, NSDate, NSNull) can be stored. Objects of type NSString will be stored as UTF8-encoded data, and are intercompatible with other keychain solutions. Any other object type will be stored using binary plist encoding. Passing a value of nil as the object will remove the key from the keychain. Passing an object of any other type (or a collection containing an object of any other type) will throw an exception. The second form of this method is functionally identical to the first, but is included to support the modern objective C keyed subscripting syntax.
    
    - (BOOL)removeObjectForKey:(id)key;
    
This method deletes the specified key from the keychain.
    
    - (id)objectForKey:(id)key;
    - (id)objectForKeyedSubscript:(id)key;

This method returns the value for the specified key from the keychain. If the key does not exist it will return nil. The second form of this method is functionally identical to the first, but is included to support the modern objective C keyed subscripting syntax.


FXKeychainAccess values
--------------------------------

    FXKeychainAccessibleWhenUnlocked
    
This is the default value. Keychain items set with this accessibility level can only be accessed when the device is unlocked. If your app needs to access the keychain when running in the background, this may cause problems.
    
    FXKeychainAccessibleAfterFirstUnlock
    
Keychain items set with this accessibility level can be accessed once the keychain has been unlocked, and will remain accessible until the device is restarted, even if the device is locked again in the meantime. This is a good choice for items that need to be accessed by background services.
    
    FXKeychainAccessibleAlways
    
Keychain items set with this accessibility level can be accessed at any time. This isn't very secure compared with the other options, but it's still better than storing values in plain text in the file system!
    
    FXKeychainAccessibleWhenUnlockedThisDeviceOnly
    FXKeychainAccessibleAfterFirstUnlockThisDeviceOnly
    FXKeychainAccessibleAlwaysThisDeviceOnly
    
These values behave the same way as their non-ThisDeviceOnly counterparts, except that they are not backed up and restored if the device is reset or upgraded, and are therefore more secure (but also less reliable).


Release Notes
----------------

Version 1.5.3

- Fixed crash when stored value is an array

Version 1.5.2

- Fixed issue on iOS 8 that may have caused crashes and made accessGroup not work correctly

Version 1.5.1

- No longer logs a warning if you attempt to delete a key that doesn't exist

Version 1.5

- The accessibility property is now readwrite, allowing you to change accessibility on a per-property basis. Note that changing the value will only affect keys that are set subsequent to the change.
- NSNull values are now stripped when saving if NSCoding is disabled, avoiding a possible cause of encoding failure in otherwise valid code
- Restored support for NSCoding, but this is enabled by default on iOS only. You can enable it for Mac OS using a precompiler macro, but this is not recommended for security reasons
- Suppressed some console warnings that would occur if password contained an = character
- Now complies with -Weverything warning level

Version 1.4

- Added access parameter for optionally allowing keychain access when device is locked

Version 1.3.4

- Fixed bug where passwords containing certain special characters could be wrongly interpreted as a property list when loading
- Added code to prevent injection attacks based on users supplying a password containing binary plist data

Version 1.3.3

- Fixed issue with deleting keychain items on Mac OS

Version 1.3.2

- Now throws an exception if you try to encode an invalid object type instead of merely logging to console

Version 1.3.1

- Fixed singleton implementation

Version 1.3

- Removed ability to store arbitrary classes in keychain for security reasons (see README). It is still possible to store dictionaries, arrays, etc.

Version 1.2

- It is now possible to actually store more than one value per FXKeychain
- Removed account parameter (it didn't work the way I thought)

Version 1.1

- Now uses application bundle ID to namespace the default keychain
- Now supports keyed subscripting (e.g. keychain["foo"] = bar;)
- Included CocoaPods podspec file
- Included Mac OS example

Version 1.0

- Initial release