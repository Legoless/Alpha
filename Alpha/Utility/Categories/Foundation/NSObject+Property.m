//
//  NSObject+Property.m
//  Alpha
//
//  Created by Dal Rupnik on 29/11/2016.
//  Copyright © 2016 Unified Sense. All rights reserved.
//

#import "NSObject+Property.h"

@import ObjectiveC.runtime;

#import "NSObject+Property.h"

@implementation NSObject (Property)

//
// Code from: http://stackoverflow.com/questions/754824/get-an-object-properties-list-in-objective-c
//

static const char *alpha_getPropertyType(objc_property_t property) {
    const char *attributes = property_getAttributes(property);
    
    char buffer[1 + strlen(attributes)];
    strcpy (buffer, attributes);
    char *state = buffer, *attribute;
    
    while ((attribute = strsep(&state, ",")) != NULL) {
        if (attribute[0] == 'T' && attribute[1] != '@') {
            // it's a C primitive type:
            /*
             if you want a list of what will be returned for these primitives, search online for
             "objective-c" "Property Attribute Description Examples"
             apple docs list plenty of examples of what you get for int "i", long "l", unsigned "I", struct, etc.
             */
            NSString *name = [[NSString alloc] initWithBytes:attribute + 1 length:strlen(attribute) - 1 encoding:NSASCIIStringEncoding];
            return (const char *)[name cStringUsingEncoding:NSASCIIStringEncoding];
        }
        else if (attribute[0] == 'T' && attribute[1] == '@' && strlen(attribute) == 2) {
            // it's an ObjC id type:
            return "id";
        }
        else if (attribute[0] == 'T' && attribute[1] == '@') {
            // it's another ObjC object type:
            NSString *name = [[NSString alloc] initWithBytes:attribute + 3 length:strlen(attribute) - 4 encoding:NSASCIIStringEncoding];
            return (const char *)[name cStringUsingEncoding:NSASCIIStringEncoding];
        }
    }
    
    return "";
}

- (NSDictionary *)alpha_properties {
    return [[self class] alpha_classPropsFor:[self class]];
}

+ (NSDictionary *)alpha_properties {
    return [self alpha_classPropsFor:self];
}

+ (NSDictionary *)alpha_classPropsFor:(Class)class {
    if (class == NULL) {
        return nil;
    }
    
    NSMutableDictionary *results = [[NSMutableDictionary alloc] init];
    
    unsigned int outCount;
    objc_property_t *properties = class_copyPropertyList(class, &outCount);
    
    for (unsigned int i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        const char *propName = property_getName(property);
        const char *propType = alpha_getPropertyType(property);
        
        if (propName && propType) {
            NSString *propertyName = [NSString stringWithUTF8String:propName];
            NSString *propertyType = [NSString stringWithUTF8String:propType];
            
            results[propertyName] = propertyType;
        }
    }
    
    free (properties);
    
    // returning a copy here to make sure the dictionary is immutable
    return [results copy];
}

@end
