//
//  NSString+Entities.m
//  Alpha
//
//  Created by Dal Rupnik on 17/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "NSString+Entities.h"

@implementation NSString (Entities)

- (NSString *)alpha_stringByEscapingHTMLEntities
{
    static NSDictionary *escapingDictionary = nil;
    static NSRegularExpression *regex = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        escapingDictionary = @{ @" " : @"&nbsp;",
                @">" : @"&gt;",
                @"<" : @"&lt;",
                @"&" : @"&amp;",
                @"'" : @"&apos;",
                @"\"" : @"&quot;",
                @"«" : @"&laquo;",
                @"»" : @"&raquo;"
        };
        regex = [NSRegularExpression regularExpressionWithPattern:@"(&|>|<|'|\"|«|»)" options:0 error:NULL];
    });

    NSMutableString *mutableString = [self mutableCopy];

    NSArray *matches = [regex matchesInString:mutableString options:0 range:NSMakeRange(0, [mutableString length])];
    for (NSTextCheckingResult *result in [matches reverseObjectEnumerator]) {
        NSString *foundString = [mutableString substringWithRange:result.range];
        NSString *replacementString = escapingDictionary[foundString];
        if (replacementString) {
            [mutableString replaceCharactersInRange:result.range withString:replacementString];
        }
    }

    return [mutableString copy];
}

@end
