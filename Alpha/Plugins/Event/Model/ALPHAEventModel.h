//
//  ALPHAEventModel.h
//  Alpha
//
//  Created by Dal Rupnik on 08/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHAModel.h"
#import "ALPHAApplicationEvent.h"

@interface ALPHAEventModel : ALPHAModel

@property (nonatomic, strong) NSArray<ALPHAApplicationEvent>* events;

@end
