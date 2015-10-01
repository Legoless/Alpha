//
//  ALPHAArgumentInputViewFactory.h
//  Alpha
//
//  Created by Ryan Olson on 6/18/14.
//  Copyright © 2014 Unified Sense. All rights reserved.
//

@import Foundation;

@class ALPHAArgumentInputView;

@interface ALPHAArgumentInputViewFactory : NSObject

/// Forwards to argumentInputViewForTypeEncoding:currentValue: with a nil currentValue.
+ (ALPHAArgumentInputView *)argumentInputViewForTypeEncoding:(const char *)typeEncoding;

/// The main factory method for making argument input view subclasses that are the best fit for the type.
+ (ALPHAArgumentInputView *)argumentInputViewForTypeEncoding:(const char *)typeEncoding currentValue:(id)currentValue;

/// A way to check if we should try editing a filed given its type encoding and value.
/// Useful when deciding whether to edit or explore a property, ivar, or NSUserDefaults value.
+ (BOOL)canEditFieldWithTypeEncoding:(const char *)typeEncoding currentValue:(id)currentValue;

@end
