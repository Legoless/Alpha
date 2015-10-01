//
//  ALPHAArgumentInputNotSupportedView.m
//  Alpha
//
//  Created by Ryan Olson on 6/18/14.
//  Copyright © 2014 Unified Sense. All rights reserved.
//

#import "ALPHAArgumentInputNotSupportedView.h"

@implementation ALPHAArgumentInputNotSupportedView

- (instancetype)initWithArgumentTypeEncoding:(const char *)typeEncoding
{
    self = [super initWithArgumentTypeEncoding:typeEncoding];
    if (self) {
        self.inputTextView.userInteractionEnabled = NO;
        self.inputTextView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1.0];
        self.inputTextView.text = @"nil";
        self.targetSize = ALPHAArgumentInputViewSizeSmall;
    }
    return self;
}

@end
