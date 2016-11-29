//
//  ALPHARuntimeUtility.h
//  Alpha
//
//  Created by Ryan Olson on 6/8/14.
//  Copyright © 2014 Unified Sense. All rights reserved.
//

@import Foundation;
@import UIKit;
@import ObjectiveC.runtime;

extern const unsigned int ALPHANumberOfImplicitArgsKey;

// See https://developer.apple.com/library/ios/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtPropertyIntrospection.html#//apple_ref/doc/uid/TP40008048-CH101-SW6
extern NSString *const ALPHAUtilityAttributeTypeEncoding;
extern NSString *const ALPHAUtilityAttributeBackingIvar;
extern NSString *const ALPHAUtilityAttributeReadOnly;
extern NSString *const ALPHAUtilityAttributeCopy;
extern NSString *const ALPHAUtilityAttributeRetain;
extern NSString *const ALPHAUtilityAttributeNonAtomic;
extern NSString *const ALPHAUtilityAttributeCustomGetter;
extern NSString *const ALPHAUtilityAttributeCustomSetter;
extern NSString *const ALPHAUtilityAttributeDynamic;
extern NSString *const ALPHAUtilityAttributeWeak;
extern NSString *const ALPHAUtilityAttributeGarbageCollectable;
extern NSString *const ALPHAUtilityAttributeOldStyleTypeEncoding;

#define ALPHAEncodeClass(class) ("@\"" #class "\"")

@interface ALPHARuntimeUtility : NSObject

//
// Frameworks
//

+ (BOOL)loadFramework:(NSString *)framework;
+ (BOOL)loadPrivateFramework:(NSString *)framework;

//
// Dynamic libraries
//

+ (void *)openPrivateDynamicLibrary:(NSString *)library;

//
// Application helpers
//
+ (NSString *)applicationImageName;
+ (NSString *)applicationName;

//
// Object helpers
//
+ (BOOL)isImagePathExtension:(NSString *)extension;
+ (NSString *)safeDescriptionForObject:(id)object;
+ (NSString *)detailDescriptionForView:(UIView *)view;
+ (UIViewController *)viewControllerForView:(UIView *)view;
+ (NSString *)descriptionForView:(UIView *)view includingFrame:(BOOL)includeFrame;

//
// Global Helpers
//
+ (NSString *)appendName:(NSString *)name toType:(NSString *)type;
+ (NSString *)prefixOfClassName:(NSString *)className;
+ (NSString *)readableTypeForEncoding:(NSString *)encodingString;

//
// Property Helpers
//
+ (NSString *)prettyNameForProperty:(objc_property_t)property;
+ (NSString *)prettyTypeForProperty:(objc_property_t)property;
+ (NSString *)typeEncodingForProperty:(objc_property_t)property;
+ (BOOL)isReadonlyProperty:(objc_property_t)property;
+ (SEL)setterSelectorForProperty:(objc_property_t)property;
+ (NSString *)fullDescriptionForProperty:(objc_property_t)property;
+ (id)valueForProperty:(objc_property_t)property onObject:(id)object;
+ (NSString *)descriptionForIvarOrPropertyValue:(id)value;
+ (void)tryAddPropertyWithName:(const char *)name attributes:(NSDictionary *)attributePairs toClass:(__unsafe_unretained Class)theClass;
+ (NSDictionary *)attributesDictionaryForProperty:(objc_property_t)property;

//
// Ivar Helpers
//
+ (NSString *)prettyNameForIvar:(Ivar)ivar;
+ (NSString *)prettyTypeForIvar:(Ivar)ivar;
+ (NSString *)typeEncodingForIvar:(Ivar)ivar;
+ (id)valueForIvar:(Ivar)ivar onObject:(id)object;
+ (void)setValue:(id)value forIvar:(Ivar)ivar onObject:(id)object;

//
// Method Helpers
//
+ (NSString *)prettyReturnTypeForMethod:(Method)method;
+ (NSString *)prettyNameForMethod:(Method)method isClassMethod:(BOOL)isClassMethod;
+ (NSArray *)prettyArgumentComponentsForMethod:(Method)method;

//
// Method Calling/Field Editing
//
+ (id)performSelector:(SEL)selector onObject:(id)object withArguments:(NSArray *)arguments error:(NSError * __autoreleasing *)error;
+ (NSString *)editableJSONStringForObject:(id)object;
+ (id)objectValueFromEditableJSONString:(NSString *)string;
+ (NSValue *)valueForNumberWithObjCType:(const char *)typeEncoding fromInputString:(NSString *)inputString;
+ (void)enumerateTypesInStructEncoding:(const char *)structEncoding usingBlock:(void (^)(NSString *structName, const char *fieldTypeEncoding, NSString *prettyTypeEncoding, NSUInteger fieldIndex, NSUInteger fieldOffset))typeBlock;
+ (NSValue *)valueForPrimitivePointer:(void *)pointer objCType:(const char *)type;

@end
