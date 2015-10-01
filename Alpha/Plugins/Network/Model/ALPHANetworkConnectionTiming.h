//
//  ALPHANetworkResourceTiming.h
//  Alpha
//
//  Created by Dal Rupnik on 06/11/14.
//  Copyright © 2014 Unified Sense. All rights reserved.
//

#import "ALPHASerialization.h"

/*!
 *  Measures timing of network connection.
 */
@interface ALPHANetworkConnectionTiming : NSObject <ALPHASerializableItem>

@property (nonatomic, copy) NSDate *connectionStartDate;

@property (nonatomic, copy) NSDate *connectionEndDate;

@property (nonatomic, copy) NSDate *redirectDate;

@end
