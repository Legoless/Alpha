//
//  ALPHAArgumentInputViewFactory.m
//  Alpha
//
//  Created by Ryan Olson on 6/18/14.
//  Copyright © 2014 Unified Sense. All rights reserved.
//

#import "ALPHAArgumentInputViewFactory.h"
#import "ALPHAArgumentInputView.h"
#import "ALPHAArgumentInputJSONObjectView.h"
#import "ALPHAArgumentInputNumberView.h"
#import "ALPHAArgumentInputSwitchView.h"
#import "ALPHAArgumentInputStructView.h"
#import "ALPHAArgumentInputNotSupportedView.h"
#import "ALPHAArgumentInputStringView.h"
#import "ALPHAArgumentInputFontView.h"
#import "ALPHAArgumentInputColorView.h"
#import "ALPHAArgumentInputDateView.h"

@implementation ALPHAArgumentInputViewFactory

+ (ALPHAArgumentInputView *)argumentInputViewForTypeEncoding:(const char *)typeEncoding
{
    return [self argumentInputViewForTypeEncoding:typeEncoding currentValue:nil];
}

+ (ALPHAArgumentInputView *)argumentInputViewForTypeEncoding:(const char *)typeEncoding currentValue:(id)currentValue
{
    Class subclass = [self argumentInputViewSubclassForTypeEncoding:typeEncoding currentValue:currentValue];
    if (!subclass) {
        // Fall back to a ALPHAArgumentInputNotSupportedView if we can't find a subclass that fits the type encoding.
        // The unsupported view shows "nil" and does not allow user input.
        subclass = [ALPHAArgumentInputNotSupportedView class];
    }
    return [[subclass alloc] initWithArgumentTypeEncoding:typeEncoding];
}

+ (Class)argumentInputViewSubclassForTypeEncoding:(const char *)typeEncoding currentValue:(id)currentValue
{
    Class argumentInputViewSubclass = nil;
    
    // Note that order is important here since multiple subclasses may support the same type.
    // An example is the number subclass and the bool subclass for the type @encode(BOOL).
    // Both work, but we'd prefer to use the bool subclass.
    if ([ALPHAArgumentInputColorView supportsObjCType:typeEncoding withCurrentValue:currentValue]) {
        argumentInputViewSubclass = [ALPHAArgumentInputColorView class];
    } else if ([ALPHAArgumentInputFontView supportsObjCType:typeEncoding withCurrentValue:currentValue]) {
        argumentInputViewSubclass = [ALPHAArgumentInputFontView class];
    } else if ([ALPHAArgumentInputStringView supportsObjCType:typeEncoding withCurrentValue:currentValue]) {
        argumentInputViewSubclass = [ALPHAArgumentInputStringView class];
    } else if ([ALPHAArgumentInputStructView supportsObjCType:typeEncoding withCurrentValue:currentValue]) {
        argumentInputViewSubclass = [ALPHAArgumentInputStructView class];
    } else if ([ALPHAArgumentInputSwitchView supportsObjCType:typeEncoding withCurrentValue:currentValue]) {
        argumentInputViewSubclass = [ALPHAArgumentInputSwitchView class];
    } else if ([ALPHAArgumentInputDateView supportsObjCType:typeEncoding withCurrentValue:currentValue]) {
        argumentInputViewSubclass = [ALPHAArgumentInputDateView class];
    } else if ([ALPHAArgumentInputNumberView supportsObjCType:typeEncoding withCurrentValue:currentValue]) {
        argumentInputViewSubclass = [ALPHAArgumentInputNumberView class];
    } else if ([ALPHAArgumentInputJSONObjectView supportsObjCType:typeEncoding withCurrentValue:currentValue]) {
        argumentInputViewSubclass = [ALPHAArgumentInputJSONObjectView class];
    }
    
    return argumentInputViewSubclass;
}

+ (BOOL)canEditFieldWithTypeEncoding:(const char *)typeEncoding currentValue:(id)currentValue
{
    return [self argumentInputViewSubclassForTypeEncoding:typeEncoding currentValue:currentValue] != nil;
}

@end
