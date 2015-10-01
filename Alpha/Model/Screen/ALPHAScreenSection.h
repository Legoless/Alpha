//
//  ALPHAScreenSection.h
//  Alpha
//
//  Created by Dal Rupnik on 20/05/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHASerializableItem.h"

#import "ALPHAScreenItem.h"
#import "ALPHAActionItem.h"
#import "ALPHAScreenActionItem.h"
#import "ALPHASelectorActionItem.h"

@interface ALPHAScreenSection : NSObject <ALPHASerializableItem>

@property (nonatomic, copy) NSString* identifier;

@property (nonatomic, copy) NSString* headerText;
@property (nonatomic, copy) NSString* footerText;

//
// Array of Display Item objects, protocols define which objects can be in array
//
@property (nonatomic, copy) NSArray* items;

- (instancetype)initWithIdentifier:(NSString *)identifier;
- (instancetype)initWithIdentifier:(NSString *)identifier title:(NSString *)title;

/*!
 *  Dictionary should be structured with a special DSL (see example). Supports NSDictionary
 *  for items or already created screen item objects - dictionary will be converted into objects.
 *
 *  @param dictionary of described data section
 *
 *  @return instantiated section
 */
+ (instancetype)screenSectionWithDictionary:(NSDictionary *)dictionary;

@end
