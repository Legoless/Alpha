//
//  ALPHAArgumentInputJSONObjectView.m
//  Alpha
//
//  Created by Ryan Olson on 6/15/14.
//  Copyright © 2014 Unified Sense. All rights reserved.
//

#import "ALPHAArgumentInputJSONObjectView.h"
#import "ALPHARuntimeUtility.h"

@implementation ALPHAArgumentInputJSONObjectView

- (instancetype)initWithArgumentTypeEncoding:(const char *)typeEncoding
{
    self = [super initWithArgumentTypeEncoding:typeEncoding];
    if (self) {
        // Start with the numbers and punctuation keyboard since quotes, curly braces, or
        // square brackets are likely to be the first characters type for the JSON.
        self.inputTextView.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        self.targetSize = ALPHAArgumentInputViewSizeLarge;
    }
    return self;
}

- (void)setInputValue:(id)inputValue
{
    self.inputTextView.text = [ALPHARuntimeUtility editableJSONStringForObject:inputValue];
}

- (id)inputValue
{
    return [ALPHARuntimeUtility objectValueFromEditableJSONString:self.inputTextView.text];
}

+ (BOOL)supportsObjCType:(const char *)type withCurrentValue:(id)value
{
    // Must be object type.
    BOOL supported = type && type[0] == '@';
    
    if (supported) {
        if (value) {
            // If there's a current value, it must be serializable to JSON
            supported = [ALPHARuntimeUtility editableJSONStringForObject:value] != nil;
        } else {
            // Otherwise, see if we have more type information than just 'id'.
            // If we do, make sure the encoding is something serializable to JSON.
            // Properties and ivars keep more detailed type encoding information than method arguments.
            if (strcmp(type, @encode(id)) != 0) {
                BOOL isJSONSerializableType = NO;
                // Note: we can't use @encode(NSString) here because that drops the string information and just goes to @encode(id).
                isJSONSerializableType = isJSONSerializableType || strcmp(type, ALPHAEncodeClass(NSString)) == 0;
                isJSONSerializableType = isJSONSerializableType || strcmp(type, ALPHAEncodeClass(NSNumber)) == 0;
                isJSONSerializableType = isJSONSerializableType || strcmp(type, ALPHAEncodeClass(NSArray)) == 0;
                isJSONSerializableType = isJSONSerializableType || strcmp(type, ALPHAEncodeClass(NSDictionary)) == 0;
                
                supported = isJSONSerializableType;
            }
        }
    }
    
    return supported;
}

@end
