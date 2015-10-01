//
//  ALPHAView.h
//  Alpha
//
//  Created by Dal Rupnik on 16/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHASerialization.h"

@import Foundation;
@import UIKit;

@protocol ALPHASerializableView <NSObject>

@end

/*!
 *  UIView into a serializable view object
 */
@interface ALPHASerializableView : NSObject <ALPHASerializableItem>

@property (nonatomic, copy) NSString *viewClass;
@property (nonatomic, copy) NSString *viewPointer;
@property (nonatomic, copy) NSString *viewDescription;

@property (nonatomic, assign) NSUInteger depth;

@property (nonatomic, copy) NSString *frame;
@property (nonatomic, copy) NSString *bounds;
@property (nonatomic, copy) NSString *center;
@property (nonatomic, copy) NSString *transform;

@property (nonatomic, copy) UIColor *backgroundColor;
@property (nonatomic, assign) CGFloat alpha;

@property (nonatomic, assign) BOOL opaque;
@property (nonatomic, assign) BOOL hidden;
@property (nonatomic, assign) BOOL clipsToBounds;
@property (nonatomic, assign) BOOL userInteractionEnabled;

@property (nonatomic, assign) NSUInteger gestureRecognizerCount;

//
// Label or text view data
//

@property (nonatomic, copy) UIColor *textColor;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *font;

- (instancetype)initWithView:(UIView *)view;

@end
