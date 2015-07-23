@interface LSBundleProxy
@property (nonatomic, readonly) NSURL *appStoreReceiptURL;
@property (nonatomic, readonly) NSURL *bundleContainerURL;
@property (nonatomic, readonly) NSString *bundleExecutable;
@property (nonatomic, readonly) NSString *bundleIdentifier;
@property (nonatomic, readonly) NSString *bundleType;
@property (nonatomic, readonly) NSURL *bundleURL;
@property (nonatomic, readonly) NSString *bundleVersion;
@property (nonatomic, readonly) NSUUID *cacheGUID;
@property (nonatomic, readonly) NSURL *containerURL;
@property (nonatomic, readonly) NSURL *dataContainerURL;
@property (nonatomic, readonly) NSDictionary *entitlements;
@property (nonatomic, readonly) NSDictionary *environmentVariables;
@property (nonatomic, readonly) BOOL foundBackingBundle;
@property (nonatomic, readonly) NSDictionary *groupContainerURLs;
@property (nonatomic, readonly) NSString *localizedShortName;
@property (nonatomic, readonly) NSArray *machOUUIDs;
@property (nonatomic, readonly) unsigned int sequenceNumber;
@property (nonatomic, readonly) NSString *signerIdentity;
@end

@interface LSApplicationProxy : LSBundleProxy <NSSecureCoding>

@property (nonatomic, readonly) NSArray *UIBackgroundModes;
@property (nonatomic, readonly) NSArray *VPNPlugins;
@property (nonatomic, readonly) NSArray *appTags;
@property (nonatomic, readonly) NSString *applicationDSID;
@property (nonatomic, readonly) NSString *applicationIdentifier;
@property (nonatomic, readonly) NSString *applicationType;
@property (nonatomic, readonly) NSArray *audioComponents;
@property (nonatomic, readonly) NSString *bundleVersion;
@property (nonatomic, readonly) NSArray *deviceFamily;
@property (nonatomic, readonly) NSUUID *deviceIdentifierForVendor;
@property (nonatomic, readonly) NSArray *directionsModes;
@property (nonatomic, readonly) NSNumber *dynamicDiskUsage;
@property (nonatomic, readonly) NSArray *externalAccessoryProtocols;
@property (nonatomic, readonly) BOOL fileSharingEnabled;
@property (nonatomic, readonly) NSDictionary *groupContainers;
@property (nonatomic, readonly) NSArray *groupIdentifiers;
@property (nonatomic, readonly) BOOL hasSettingsBundle;
@property (nonatomic, readonly) BOOL iconIsPrerendered;
@property (nonatomic, readonly) NSProgress *installProgress;
@property (nonatomic, readonly) unsigned int installType;
@property (nonatomic, readonly) BOOL isAppUpdate;
@property (nonatomic, readonly) BOOL isBetaApp;
@property (nonatomic, readonly) BOOL isContainerized;
@property (nonatomic, readonly) BOOL isInstalled;
@property (nonatomic, readonly) BOOL isNewsstandApp;
@property (nonatomic, readonly) BOOL isPlaceholder;
@property (nonatomic, readonly) BOOL isPurchasedReDownload;
@property (nonatomic, readonly) BOOL isRestricted;
@property (nonatomic, readonly) BOOL isWatchKitApp;
@property (nonatomic, readonly) NSNumber *itemID;
@property (nonatomic, readonly) NSString *itemName;
@property (nonatomic, readonly) NSString *minimumSystemVersion;
@property (nonatomic, readonly) unsigned int originalInstallType;
@property (nonatomic, readonly) NSArray *plugInKitPlugins;
@property (nonatomic, readonly) BOOL profileValidated;
@property (nonatomic, readonly) NSArray *requiredDeviceCapabilities;
@property (nonatomic, readonly) NSString *roleIdentifier;
@property (nonatomic, readonly) NSString *sdkVersion;
@property (nonatomic, readonly) NSString *shortVersionString;
@property (nonatomic, readonly) NSString *sourceAppIdentifier;
@property (nonatomic, readonly) NSNumber *staticDiskUsage;
@property (nonatomic, readonly) NSString *storeCohortMetadata;
@property (nonatomic, readonly) NSNumber *storeFront;
@property (nonatomic, readonly) BOOL supportsAudiobooks;
@property (nonatomic, readonly) BOOL supportsExternallyPlayableContent;
@property (nonatomic, readonly) NSString *teamID;
@property (nonatomic, readonly) NSString *vendorName;

+ (id)applicationProxyForBundleURL:(id)arg1;
+ (id)applicationProxyForIdentifier:(id)arg1;
+ (id)applicationProxyForIdentifier:(id)arg1 placeholder:(BOOL)arg2;
+ (id)applicationProxyForIdentifier:(id)arg1 roleIdentifier:(id)arg2;
+ (id)applicationProxyForItemID:(id)arg1;
+ (id)applicationProxyWithBundleUnitID:(unsigned long)arg1;
+ (BOOL)supportsSecureCoding;

@end