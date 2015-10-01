//
//  ALPHANetworkInitiator.h
//  Alpha
//
//  Created by Dal Rupnik on 06/11/14.
//  Copyright © 2014 Unified Sense. All rights reserved.
//

#import "ALPHASerialization.h"

@interface ALPHANetworkInitiator : NSObject <ALPHASerializableItem>

// Type of this initiator.
// Type: string
@property (nonatomic, strong) NSString *type;

// Initiator JavaScript stack trace, set for Script only.
@property (nonatomic, strong) NSArray *stackTrace;

// Initiator URL, set for Parser type only.
// Type: string
@property (nonatomic, strong) NSString *url;

// Initiator line number, set for Parser type only.
// Type: number
@property (nonatomic, strong) NSNumber *lineNumber;

@end
