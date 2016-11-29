//
//  NSString+Identifier.m
//  Alpha
//
//  Created by Dal Rupnik on 08/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "NSString+Identifier.h"

@implementation NSString (Identifier)

- (NSString *)alpha_cleanCodeIdentifier
{
    return [[self alpha_removeNamespacePrefix] alpha_titleCaseForCamelCase];
}

- (NSString *)alpha_removeNamespacePrefix
{
    NSInteger location = 0;
    
    for (NSInteger i = 0; i < self.length; i++)
    {
        NSString *chr = [self substringWithRange:NSMakeRange(i, 1)];
        
        if ([chr rangeOfCharacterFromSet:[NSCharacterSet uppercaseLetterCharacterSet]].location == NSNotFound)
        {
            location = i - 1;
            break;
        }
    }
    
    if (location < 0)
    {
        location = 0;
    }
    
    return [[self substringFromIndex:location] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)alpha_titleCaseForCamelCase
{
    NSMutableString *titleCase = [NSMutableString string];
    
    for (NSInteger i = 0; i < self.length; i++)
    {
        NSString *chr = [self substringWithRange:NSMakeRange(i, 1)];
        
        if ([chr rangeOfCharacterFromSet:[NSCharacterSet uppercaseLetterCharacterSet]].location != NSNotFound)
        {
            [titleCase appendString:@" "];
        }
        
        [titleCase appendString:chr];
    }
    
    return [[titleCase stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] capitalizedString];
}

@end
