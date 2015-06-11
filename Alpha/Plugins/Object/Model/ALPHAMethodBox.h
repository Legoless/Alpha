//
//  ALPHAMethodBox.h
//  Alpha
//
//  Created by Dal Rupnik on 11/06/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "ALPHASerialization.h"

@interface ALPHAMethodBox : NSObject <ALPHASerializableItem>

@property (nonatomic, copy) NSString *methodName;
@property (nonatomic, copy) NSString *methodReturnType;

@property (nonatomic, assign) BOOL isClassMethod;

@property (nonatomic, copy) NSArray *arguments;

- (NSString *)prettyDescription;

@end
