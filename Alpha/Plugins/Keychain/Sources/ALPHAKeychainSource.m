//
//  ALPHAKeychainSource.m
//  Alpha
//
//  Created by Dal Rupnik on 01/10/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHAKeychainSource.h"
#import "ALPHATableScreenModel.h"
#import "ALPHAKeychainItem.h"

NSString *const ALPHAKeychainDataIdentifier = @"com.unifiedsense.alpha.data.keychain";

@interface ALPHAKeychainSource ()

@property (nonatomic, copy) NSArray *items;

@end


@implementation ALPHAKeychainSource

- (NSArray *)keychainItems
{
    //
    // http://stackoverflow.com/questions/10966969/enumerate-all-keychain-items-in-my-ios-application
    //
    
    NSMutableDictionary *query = [@{ (__bridge id)kSecReturnAttributes : (__bridge id)kCFBooleanTrue,
                                     (__bridge id)kSecMatchLimit : (__bridge id)kSecMatchLimitAll,
                                     (__bridge id)kSecReturnData : (__bridge id)kCFBooleanTrue
                                 } mutableCopy];
    
    
    NSArray *secItemClasses = @[ (__bridge id)kSecClassGenericPassword, (__bridge id)kSecClassInternetPassword, (__bridge id)kSecClassCertificate, (__bridge id)kSecClassKey, (__bridge id)kSecClassIdentity ];
    
    NSMutableArray *items = [NSMutableArray array];
    
    for (id secItemClass in secItemClasses)
    {
        [query setObject:secItemClass forKey:(__bridge id)kSecClass];
        
        CFTypeRef result = NULL;
        SecItemCopyMatching((__bridge CFDictionaryRef)query, &result);
        
        id item = (__bridge id)result;

        if (result != NULL)
        {
            //NSLog(@"REsult: %@", result);
            
            [items addObject:[[ALPHAKeychainItem alloc] initWithDictionary:[item firstObject]]];
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
    screenModel.title = @"Keychain Items";
    
    ALPHAScreenSection* section = [[ALPHAScreenSection alloc] init];
    
    self.items = [self keychainItems];
    
    NSMutableArray* items = [NSMutableArray array];
    
    for (ALPHAKeychainItem* keychainItem in self.items)
    {
        ALPHAScreenItem* item = [[ALPHAScreenItem alloc] init];
        item.title = keychainItem.account;
        item.detail = keychainItem.service;
        item.style = UITableViewCellStyleSubtitle;
        
        item.object = [ALPHARequest requestForObject:keychainItem];
        
        [items addObject:item];
    }
        
    section.items = items;
    
    screenModel.sections = @[ section ];
    
    return screenModel;
}


@end
