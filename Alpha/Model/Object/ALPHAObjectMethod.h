//
//  ALPHAObjectMethod.h
//  Alpha
//
//  Created by Dal Rupnik on 11/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHAObjectElement.h"
#import "ALPHAObjectArgument.h"

@protocol ALPHAObjectMethod <NSObject>

@end

@interface ALPHAObjectMethod : ALPHAObjectElement <ALPHAObjectPrintable>

@property (nonatomic, strong) ALPHAObjectType *returnType;

@property (nonatomic, assign) BOOL isClassMethod;

@property (nonatomic, copy) NSArray<ALPHAObjectArgument> *arguments;

- (NSString *)prettyDescription;

@end
