//
//  ALPHAGenericConverter.m
//  Alpha
//
//  Created by Dal Rupnik on 03/06/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "ALPHAGenericConverter.h"

@implementation ALPHAGenericConverter

- (BOOL)canConvertModel:(ALPHAModel *)model
{
    return [model isKindOfClass:[ALPHAModel class]];
}

- (ALPHAScreenModel *)screenModelForModel:(ALPHAModel *)model
{
    return nil;
}

@end
