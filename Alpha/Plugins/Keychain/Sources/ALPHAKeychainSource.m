//
//  ALPHAKeychainSource.m
//  Alpha
//
//  Created by Dal Rupnik on 01/10/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHAKeychainSource.h"
#import "ALPHATableScreenModel.h"

NSString *const ALPHAKeychainDataIdentifier = @"com.unifiedsense.alpha.data.keychain";

@implementation ALPHAKeychainSource

- (NSArray *)keychainItems
{
    //
    // http://stackoverflow.com/questions/10966969/enumerate-all-keychain-items-in-my-ios-application
    //
    
    NSMutableDictionary *query = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  (__bridge id)kCFBooleanTrue, (__bridge id)kSecReturnAttributes,
                                  (__bridge id)kSecMatchLimitAll, (__bridge id)kSecMatchLimit,
                                  nil];
    
    NSArray *secItemClasses = @[ (__bridge id)kSecClassGenericPassword, (__bridge id)kSecClassInternetPassword, (__bridge id)kSecClassCertificate, (__bridge id)kSecClassKey, (__bridge id)kSecClassIdentity ];
    
    NSMutableArray *items = [NSMutableArray array];
    
    for (id secItemClass in secItemClasses)
    {
        [query setObject:secItemClass forKey:(__bridge id)kSecClass];
        
        CFTypeRef result = NULL;
        SecItemCopyMatching((__bridge CFDictionaryRef)query, &result);
        
        id item = (__bridge id)result;
        
        NSLog(@"Result: %@", item);
        
        [items addObject:item];
        
        if (result != NULL)
        {
            CFRelease(result);
        }
    }
    
    return items.copy;
}

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        [self addDataIdentifier:ALPHAKeychainDataIdentifier];
    }
    
    return self;
}

- (ALPHAModel *)modelForRequest:(ALPHARequest *)request
{
    
    ALPHATableScreenModel* screenModel = [[ALPHATableScreenModel alloc] initWithIdentifier:ALPHAKeychainDataIdentifier];
    screenModel.title = @"Screenshots";
    
    ALPHAScreenSection* section = [[ALPHAScreenSection alloc] init];
    
    NSArray *keychainItems = [self keychainItems];
    
    NSMutableArray* items = [NSMutableArray array];
    
    for (id keychainItem in keychainItems)
    {
        ALPHAScreenItem* item = [[ALPHAScreenItem alloc] init];
        item.title = [keychainItem description];
        //item.object = [ALPHARequest requestForFile:screenshot.absoluteString];
        
        [items addObject:item];
    }
    
    section.items = items;
    
    screenModel.sections = @[ section ];
    
    return screenModel;
}


@end
