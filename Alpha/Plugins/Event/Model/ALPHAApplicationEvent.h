//
//  ALPHAApplicationEvent.h
//  Alpha
//
//  Created by Dal Rupnik on 08/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHASerializableItem.h"

@protocol ALPHAApplicationEvent <NSObject>

@end

@interface ALPHAApplicationEvent : NSObject <ALPHASerializableItem>

@property (nonatomic, copy) NSString* name;
@property (nonatomic, copy) NSDate *date;

@property (nonatomic, copy) NSString* sender;

@property (nonatomic, copy) NSDictionary* info;

@end
