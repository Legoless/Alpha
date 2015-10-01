//
//  ALPHAHeapEnumerator.h
//  Alpha
//
//  Created by Dal Rupnik on 17/6/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

@import Foundation;

typedef void (^ALPHAObjectEnumerationBlock)(__unsafe_unretained id object, __unsafe_unretained Class actualClass);

@interface ALPHAHeapEnumerator : NSObject

+ (void)enumerateLiveObjectsUsingBlock:(ALPHAObjectEnumerationBlock)block;

@end
