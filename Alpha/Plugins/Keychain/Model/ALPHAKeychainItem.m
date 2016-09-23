//
//  ALPHAKeychainItem.m
//  Alpha
//
//  Created by Dal Rupnik on 01/10/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

@import Security;

#import "ALPHAKeychainItem.h"

@implementation ALPHAKeychainItem

+ (BOOL)supportsSecureCoding {
    return YES;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    
    if (self)
    {
        self.account = dictionary[(__bridge id)kSecAttrAccount];
        self.service = dictionary[(__bridge id)kSecAttrService];
        
        self.accessibilityType = dictionary[(__bridge id)kSecAttrAccessible];
        
        self.value = dictionary[(__bridge id)kSecValueData];
        
        if (self.value)
        {
            self.valueString = [[NSString alloc] initWithData:self.value encoding:NSUTF8StringEncoding];
        }
        
        self.createdDate = dictionary[(__bridge id)kSecAttrCreationDate];
        self.modifiedDate = dictionary[(__bridge id)kSecAttrModificationDate];
    }
    
    return self;
}

@end
