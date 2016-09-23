//
//  ALPHAObjectElement.m
//  Alpha
//
//  Created by Dal Rupnik on 15/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHAObjectElement.h"

@implementation ALPHAObjectElement

+ (BOOL)supportsSecureCoding {
    return YES;
}

+ (NSString *)descriptionForIvarOrPropertyValue:(id)value {
    NSString *description = nil;
    
    // Special case BOOL for better readability.
    if ([value isKindOfClass:[NSValue class]]) {
        const char *type = [value objCType];
        if (strcmp(type, @encode(BOOL)) == 0) {
            BOOL boolValue = NO;
            [value getValue:&boolValue];
            description = boolValue ? @"YES" : @"NO";
        } else if (strcmp(type, @encode(SEL)) == 0) {
            SEL selector = NULL;
            [value getValue:&selector];
            description = NSStringFromSelector(selector);
        }
    }
    
    if (!description) {
        // Single line display - replace newlines and tabs with spaces.
        description = [[value description] stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
        description = [description stringByReplacingOccurrencesOfString:@"\t" withString:@" "];
    }
    
    if (!description) {
        description = @"nil";
    }
    
    return description;
}

@end
