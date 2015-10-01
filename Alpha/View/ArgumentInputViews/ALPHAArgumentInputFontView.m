//
//  ALPHAArgumentInputFontView.m
//  Alpha
//
//  Created by Ryan Olson on 6/28/14.
//  Copyright © 2014 Unified Sense. All rights reserved.
//

#import "ALPHAArgumentInputFontView.h"
#import "ALPHAArgumentInputViewFactory.h"
#import "ALPHARuntimeUtility.h"
#import "ALPHAArgumentInputFontsPickerView.h"

@interface ALPHAArgumentInputFontView ()

@property (nonatomic, strong) ALPHAArgumentInputView *fontNameInput;
@property (nonatomic, strong) ALPHAArgumentInputView *pointSizeInput;

@end

@implementation ALPHAArgumentInputFontView

- (instancetype)initWithArgumentTypeEncoding:(const char *)typeEncoding
{
    self = [super initWithArgumentTypeEncoding:typeEncoding];
    if (self) {
        self.fontNameInput = [[ALPHAArgumentInputFontsPickerView alloc] initWithArgumentTypeEncoding:ALPHAEncodeClass(NSString)];
        self.fontNameInput.backgroundColor = self.backgroundColor;
        self.fontNameInput.targetSize = ALPHAArgumentInputViewSizeSmall;
        self.fontNameInput.title = @"Font Name:";
        [self addSubview:self.fontNameInput];
        
        self.pointSizeInput = [ALPHAArgumentInputViewFactory argumentInputViewForTypeEncoding:@encode(CGFloat)];
        self.pointSizeInput.backgroundColor = self.backgroundColor;
        self.pointSizeInput.targetSize = ALPHAArgumentInputViewSizeSmall;
        self.pointSizeInput.title = @"Point Size:";
        [self addSubview:self.pointSizeInput];
    }
    return self;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    [super setBackgroundColor:backgroundColor];
    self.fontNameInput.backgroundColor = backgroundColor;
    self.pointSizeInput.backgroundColor = backgroundColor;
}

- (void)setInputValue:(id)inputValue
{
    if ([inputValue isKindOfClass:[UIFont class]]) {
        UIFont *font = (UIFont *)inputValue;
        self.fontNameInput.inputValue = font.fontName;
        self.pointSizeInput.inputValue = @(font.pointSize);
    }
}

- (id)inputValue
{
    CGFloat pointSize = 0;
    if ([self.pointSizeInput.inputValue isKindOfClass:[NSValue class]]) {
        NSValue *pointSizeValue = (NSValue *)self.pointSizeInput.inputValue;
        if (strcmp([pointSizeValue objCType], @encode(CGFloat)) == 0) {
            [pointSizeValue getValue:&pointSize];
        }
    }
    return [UIFont fontWithName:self.fontNameInput.inputValue size:pointSize];
}

- (BOOL)inputViewIsFirstResponder
{
    return [self.fontNameInput inputViewIsFirstResponder] || [self.pointSizeInput inputViewIsFirstResponder];
}


#pragma mark - Layout and Sizing

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat runningOriginY = self.topInputFieldVerticalLayoutGuide;
    
    CGSize fontNameFitSize = [self.fontNameInput sizeThatFits:self.bounds.size];
    self.fontNameInput.frame = CGRectMake(0, runningOriginY, fontNameFitSize.width, fontNameFitSize.height);
    runningOriginY = CGRectGetMaxY(self.fontNameInput.frame) + [[self class] verticalPaddingBetweenFields];
    
    CGSize pointSizeFitSize = [self.pointSizeInput sizeThatFits:self.bounds.size];
    self.pointSizeInput.frame = CGRectMake(0, runningOriginY, pointSizeFitSize.width, pointSizeFitSize.height);
}

+ (CGFloat)verticalPaddingBetweenFields
{
    return 10.0;
}

- (CGSize)sizeThatFits:(CGSize)size
{
    CGSize fitSize = [super sizeThatFits:size];
    
    CGSize constrainSize = CGSizeMake(size.width, CGFLOAT_MAX);
    
    CGFloat height = fitSize.height;
    height += [self.fontNameInput sizeThatFits:constrainSize].height;
    height += [[self class] verticalPaddingBetweenFields];
    height += [self.pointSizeInput sizeThatFits:constrainSize].height;
    
    return CGSizeMake(fitSize.width, height);
}


#pragma mark -

+ (BOOL)supportsObjCType:(const char *)type withCurrentValue:(id)value
{
    BOOL supported = type && strcmp(type, ALPHAEncodeClass(UIFont)) == 0;
    supported = supported || (value && [value isKindOfClass:[UIFont class]]);
    return supported;
}

@end
