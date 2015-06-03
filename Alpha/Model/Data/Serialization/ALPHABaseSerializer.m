//
//  ALPHABaseSerializer.m
//  Alpha
//
//  Created by Dal Rupnik on 03/06/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

//
// Copyright (c) 2012 The Board of Trustees of The University of Alabama
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions
// are met:
//
// 1. Redistributions of source code must retain the above copyright
// notice, this list of conditions and the following disclaimer.
// 2. Redistributions in binary form must reproduce the above copyright
// notice, this list of conditions and the following disclaimer in the
// documentation and/or other materials provided with the distribution.
// 3. Neither the name of the University nor the names of the contributors
// may be used to endorse or promote products derived from this software
// without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
// "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
// LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
// FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL
// THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
// INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
//  SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
// HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
// STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
// ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
// OF THE POSSIBILITY OF SUCH DAMAGE.
//

#import <objc/runtime.h>

#import "ALPHABaseSerializer.h"

@implementation ALPHABaseSerializer

#pragma mark - Getters and Setters

#pragma mark - Object -> Dictionary serialization

- (id)serializeObject:(id)object
{
    id returnObject = nil;
    
    if ([object isKindOfClass:[NSArray class]])
    {
        NSInteger length = [(NSArray *)object count];
        returnObject = [NSMutableArray arrayWithCapacity:length];
        
        for (NSInteger i = 0; i < length; i++)
        {
            [returnObject addObject:[self serializeObject:[(NSArray *)object objectAtIndex:i]]];
        }
    }
    else
    {
        // Custom objects are serialized into dictionary with properties as keys
        returnObject = [self serializeCustomObject:object];
    }
    
    return returnObject;
}

- (id)serializeCustomObject:(id)object
{
    if ([self classIsFinal:[object class]])
    {
        return [object copy];
    }
    else if ([object isKindOfClass:[UIImage class]])
    {
        return UIImagePNGRepresentation(object);
    }
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    //
    // Any NSObject
    //
    
    NSArray *propertiesArray = [self propertyDictionaryOfClass:[object class]].allKeys;
    
    for (NSInteger i = 0; i < propertiesArray.count; i++)
    {
        NSString *key = propertiesArray[i];
        
        id propertyObject = [object valueForKey:key];
        
        if (!propertyObject)
        {
            continue;
        }
        
        [dictionary setObject:[self serializeObject:propertyObject] forKey:key];
    }
    
    return dictionary.copy;
}


#pragma mark - Dictionary & Array -> Object serialization

/*!
 *  Method takes any object as parameter and returns instance of class if serialization is successful
 *
 *  @param objectClass class to serialize to
 *  @param object      object
 *
 *  @return array or instance of an object
 */
- (id)deserializeObject:(id)object toClass:(Class)objectClass
{
    id newObject = nil;
    
    //
    // If it is an array of objects we try to serialize them recursively
    //
    if ([object isKindOfClass:[NSArray class]])
    {
        NSInteger length = [((NSArray*) object) count];
        NSMutableArray *resultArray = [NSMutableArray arrayWithCapacity:length];
        
        for (NSInteger i = 0; i < length; i++)
        {
            [resultArray addObject:[self deserializeObject:[(NSArray*)object objectAtIndex:i] toClass:objectClass]];
        }
        
        newObject = resultArray.copy;
    }
    //
    // If object is a top-level object dictionary already we can serialize it into object and we do not expect it
    // to be a dictionary.
    //
    else
    {
        newObject = [self deserializeCustomObject:object toClass:objectClass];
    }
    
    return newObject;
}

#pragma mark - Dictionary -> Object serialization

- (id)deserializeCustomObject:(id)object toClass:(Class)objectClass
{
    if ([self classIsFinal:objectClass])
    {
        return [object copy];
    }
    // Just return the type directly
    else if ([object isKindOfClass:[NSData class]] && objectClass == [UIImage class])
    {
        return [UIImage imageWithData:object];
    }
    
    //
    // Custom object
    //
    
    id newObject = [[objectClass alloc] init];
    
    NSDictionary *mapDictionary = [newObject propertyDictionaryOfClass:objectClass];
    
    for (NSString *key in [object allKeys])
    {
        NSString *propertyName = [mapDictionary objectForKey:key];;
        
        if (!propertyName)
        {
            continue;
        }
        
        // If it's null, set to nil and continue
        if ([object objectForKey:key] == [NSNull null])
        {
            [newObject setValue:nil forKey:propertyName];
            continue;
        }
        
        NSString *propertyType = [self classOfPropertyNamed:propertyName inClass:[newObject class]];
        
        // If it's an array, check for each object in array -> make into object/id
        if ([[object objectForKey:key] isKindOfClass:[NSArray class]])
        {
            NSArray *nestedArray = [object objectForKey:key];
            
            NSString *arrayType = [self typeFromProtocolOfObject:nestedArray];
            [newObject setValue:[self deserializeObject:nestedArray toClass:NSClassFromString(arrayType)] forKey:propertyName];
        }
        
        // Add to property name, because it is a type already, handle conversions
        else
        {
            [newObject setValue:[self deserializeObject:[object objectForKey:key] toClass:NSClassFromString(propertyType)] forKey:propertyName];
        }
    }
    
    return newObject;
}

#pragma mark - Private methods

- (BOOL)classIsFinal:(Class)class
{
    NSArray *finalObjectClassNames = @[ @"NSArray", @"NSDictionary", @"NSString", @"NSData", @"NSDate", @"NSNumber" ];
    
    for (NSString *className in finalObjectClassNames)
    {
        Class finalClass = NSClassFromString(className);
        
        if ([class isSubclassOfClass:finalClass] || class == finalClass)
        {
            return YES;
        }
    }
    
    return NO;
}

/*!
 *  Returns a dictionary of all properties of Class, including all superclasses up to NSObject
 *
 *  @param class target class
 *
 *  @return dictionary of class properties
 */
- (NSDictionary *)propertyDictionaryOfClass:(Class)class
{
    // Add properties of Self
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    unsigned count;
    objc_property_t *properties = class_copyPropertyList(class, &count);
    
    for (NSInteger i = 0; i < count; i++)
    {
        NSString *key = [NSString stringWithUTF8String:property_getName(properties[i])];
        
        dict[key] = key;
    }
    
    free (properties);
    
    // Add all superclass properties of Self as well, until it hits NSObject
    NSString *superClassName = [self nameOfClass:[class superclass]];
    
    if (![superClassName isEqualToString:@"NSObject"])
    {
        for (NSString *property in [[self propertyDictionaryOfClass:[class superclass]] allKeys])
        {
            dict[property] = property;
        }
    }
    
    // Return the Dict
    return dict;
}

/*!
 *  Returns string that represents either class or type of property
 *
 *  @param propName property name
 *  @param class    property in class
 *
 *  @return string of class or type
 */
- (NSString *)classOfPropertyNamed:(NSString *)propName inClass:(Class)class
{
    objc_property_t theProperty = class_getProperty(class, [propName UTF8String]);
    
    const char *attributes = property_getAttributes(theProperty);
    char buffer[1 + strlen(attributes)];
    strcpy(buffer, attributes);
    char *state = buffer, *attribute;
    
    NSString* className = @"";
    
    while ((attribute = strsep(&state, ",")) != NULL)
    {
        if (attribute[0] == 'T' && attribute[1] != '@')
        {
            // it's a C primitive type:
            /*
             if you want a list of what will be returned for these primitives, search online for
             "objective-c" "Property Attribute Description Examples"
             apple docs list plenty of examples of what you get for int "i", long "l", unsigned "I", struct, etc.*/
            className = [[NSString alloc] initWithData:[NSData dataWithBytes:(attribute + 1) length:strlen(attribute) - 1] encoding:NSUTF8StringEncoding];
        }
        else if (attribute[0] == 'T' && attribute[1] == '@' && strlen(attribute) == 2) {
            // it's an ObjC id type:
            className = @"id";
        }
        else if (attribute[0] == 'T' && attribute[1] == '@') {
            // it's another ObjC object type:
            NSData *data = [NSData dataWithBytes:(attribute + 3) length:strlen(attribute) - 4];
            className = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        }
    }
    
    return className;
}

/*!
 *  Returns type that is taken from protocol of object, for use to get property type of an array
 *
 *  @param object object that conforms to at least one protocol
 *
 *  @return type from protocol, if unable to determine it returns NSDictionary
 */
- (NSString *)typeFromProtocolOfObject:(id)object
{
    unsigned int count;
    __unsafe_unretained Protocol **protocols = class_copyProtocolList(object, &count);
    
    NSString* typeName = @"NSDictionary";
    
    NSArray* ignoredPrefixes = @[ @"NS", @"UI", @"IB" ];
    
    for (unsigned i = 0; i < count; i++)
    {
        NSString* protocolName = [NSString stringWithUTF8String: protocol_getName(protocols[i])];
        
        BOOL foundPrefix = NO;
        
        for (NSString* prefix in ignoredPrefixes)
        {
            if ([protocolName hasPrefix:prefix])
            {
                foundPrefix = YES;
            }
        }
        
        // Ignore Apple prefixes
        if (!foundPrefix)
        {
            typeName = protocolName;
        }
    }
    
    free(protocols);
    
    return typeName;
}

- (NSString *)nameOfClass:(Class)class
{
    return [NSString stringWithUTF8String:class_getName(class)];
}

#pragma mark - Base64 Binary Encode/Decode

static const char _base64EncodingTable[64] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

+ (NSData *)base64DataFromString:(NSString *)string
{
    unsigned long ixtext, lentext;
    unsigned char ch, inbuf[4], outbuf[3];
    short i, ixinbuf;
    Boolean flignore, flendtext = false;
    const unsigned char *tempcstring;
    NSMutableData *theData;
    
    if (string == nil) {
        return [NSData data];
    }
    
    ixtext = 0;
    tempcstring = (const unsigned char *)[string UTF8String];
    lentext = [string length];
    theData = [NSMutableData dataWithCapacity: lentext];
    ixinbuf = 0;
    
    while (true)
    {
        if (ixtext >= lentext) {
            break;
        }
        
        ch = tempcstring [ixtext++];
        flignore = false;
        
        if ((ch >= 'A') && (ch <= 'Z')) {
            ch = ch - 'A';
        }
        else if ((ch >= 'a') && (ch <= 'z')) {
            ch = ch - 'a' + 26;
        }
        else if ((ch >= '0') && (ch <= '9')) {
            ch = ch - '0' + 52;
        }
        else if (ch == '+') {
            ch = 62;
        }
        else if (ch == '=') {
            flendtext = true;
        }
        else if (ch == '/') {
            ch = 63;
        }
        else {
            flignore = true;
        }
        
        if (!flignore)
        {
            short ctcharsinbuf = 3;
            Boolean flbreak = false;
            
            if (flendtext) {
                if (ixinbuf == 0) {
                    break;
                }
                
                if ((ixinbuf == 1) || (ixinbuf == 2)) {
                    ctcharsinbuf = 1;
                }
                else {
                    ctcharsinbuf = 2;
                }
                ixinbuf = 3;
                flbreak = true;
            }
            
            inbuf [ixinbuf++] = ch;
            
            if (ixinbuf == 4) {
                ixinbuf = 0;
                outbuf[0] = (inbuf[0] << 2) | ((inbuf[1] & 0x30) >> 4);
                outbuf[1] = ((inbuf[1] & 0x0F) << 4) | ((inbuf[2] & 0x3C) >> 2);
                outbuf[2] = ((inbuf[2] & 0x03) << 6) | (inbuf[3] & 0x3F);
                
                for (i = 0; i < ctcharsinbuf; i++) {
                    [theData appendBytes: &outbuf[i] length: 1];
                }
            }
            
            if (flbreak) {
                break;
            }
        }
    }
    
    return theData;
}

+ (NSString *)encodeBase64WithData:(NSData *)objData
{
    const unsigned char * objRawData = [objData bytes];
    char * objPointer;
    char * strResult;
    
    // Get the Raw Data length and ensure we actually have data
    NSInteger intLength = [objData length];
    if (intLength == 0) return nil;
    
    // Setup the String-based Result placeholder and pointer within that placeholder
    strResult = (char *)calloc(((intLength + 2) / 3) * 4, sizeof(char));
    objPointer = strResult;
    
    // Iterate through everything
    while (intLength > 2) { // keep going until we have less than 24 bits
        *objPointer++ = _base64EncodingTable[objRawData[0] >> 2];
        *objPointer++ = _base64EncodingTable[((objRawData[0] & 0x03) << 4) + (objRawData[1] >> 4)];
        *objPointer++ = _base64EncodingTable[((objRawData[1] & 0x0f) << 2) + (objRawData[2] >> 6)];
        *objPointer++ = _base64EncodingTable[objRawData[2] & 0x3f];
        
        // we just handled 3 octets (24 bits) of data
        objRawData += 3;
        intLength -= 3;
    }
    
    // now deal with the tail end of things
    if (intLength != 0) {
        *objPointer++ = _base64EncodingTable[objRawData[0] >> 2];
        if (intLength > 1) {
            *objPointer++ = _base64EncodingTable[((objRawData[0] & 0x03) << 4) + (objRawData[1] >> 4)];
            *objPointer++ = _base64EncodingTable[(objRawData[1] & 0x0f) << 2];
            *objPointer++ = '=';
        }
        else {
            *objPointer++ = _base64EncodingTable[(objRawData[0] & 0x03) << 4];
            *objPointer++ = '=';
            *objPointer++ = '=';
        }
    }
    
    // Terminate the string-based result
    *objPointer = '\0';
    
    // Return the results as an NSString object
    return [NSString stringWithCString:strResult encoding:NSUTF8StringEncoding];
}

@end
