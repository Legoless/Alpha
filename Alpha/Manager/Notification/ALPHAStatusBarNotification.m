//
//  ALPHAStatusBarNotification.m
//  Alpha
//
//  Created by Dal Rupnik on 17/6/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

//
// This code is adapted from CWStatusBarNotification and is a thinner,
// optimized version customised for Alpha.
//

// The MIT License (MIT)
//
// Copyright © 2014 Cezary Wojcik <http://www.cezarywojcik.com>
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "ALPHAStatusBarNotification.h"

#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

#define STATUS_BAR_ANIMATION_LENGTH 0.25f
#define FONT_SIZE 12.0f
#define PADDING 10.0f
#define SCROLL_SPEED 40.0f
#define SCROLL_DELAY 1.0f

#pragma mark - Static methods

# pragma mark - dispatch after with cancellation
// adapted from: https://github.com/Spaceman-Labs/Dispatch-Cancel

typedef void(^ALPHADelayedBlockHandle)(BOOL cancel);

static ALPHADelayedBlockHandle perform_block_after_delay(CGFloat seconds, dispatch_block_t block)
{
    if (block == nil) {
        return nil;
    }

    __block dispatch_block_t blockToExecute = [block copy];
    __block ALPHADelayedBlockHandle delayHandleCopy = nil;

    ALPHADelayedBlockHandle delayHandle = ^(BOOL cancel){
        if (NO == cancel && nil != blockToExecute) {
            dispatch_async(dispatch_get_main_queue(), blockToExecute);
        }

        blockToExecute = nil;
        delayHandleCopy = nil;
    };

    delayHandleCopy = [delayHandle copy];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, seconds * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        if (nil != delayHandleCopy) {
            delayHandleCopy(NO);
        }
    });

    return delayHandleCopy;
};

static void cancel_delayed_block(ALPHADelayedBlockHandle delayedHandle)
{
    if (delayedHandle == nil) {
        return;
    }

    delayedHandle(YES);
}

#pragma mark - Notification Scroll Label

@interface ALPHANotificationScrollLabel : UILabel

- (CGFloat)scrollTime;

@end

@implementation ALPHANotificationScrollLabel
{
    UIImageView *textImage;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        textImage = [[UIImageView alloc] init];
        [self addSubview:textImage];
    }
    return self;
}

- (CGFloat)fullWidth
{
    return [self.text sizeWithAttributes:@{ NSFontAttributeName: self.font }].width;
}

- (CGFloat)scrollOffset
{
    if (self.numberOfLines != 1)
    {
        return 0;
    }

    CGRect insetRect = CGRectInset(self.bounds, PADDING, 0);
    return MAX(0, [self fullWidth] - insetRect.size.width);
}

- (CGFloat)scrollTime
{
    return ([self scrollOffset] > 0) ? [self scrollOffset] / SCROLL_SPEED + SCROLL_DELAY : 0;
}

- (void)drawTextInRect:(CGRect)rect
{
    if ([self scrollOffset] > 0)
    {
        rect.size.width = [self fullWidth] + PADDING * 2;
        UIGraphicsBeginImageContextWithOptions(rect.size, NO, [UIScreen mainScreen].scale);
        [super drawTextInRect:rect];
        textImage.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        [textImage sizeToFit];
        [UIView animateWithDuration:[self scrollTime] - SCROLL_DELAY
                              delay:SCROLL_DELAY
                            options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             textImage.transform = CGAffineTransformMakeTranslation(-[self scrollOffset], 0);
                         } completion:^(BOOL finished) {
                }];
    }
    else
    {
        textImage.image = nil;
        [super drawTextInRect:CGRectInset(rect, PADDING, 0)];
    }
}

@end

#pragma mark - Notification Window

@interface ALPHANotificationWindow : UIWindow

@property (assign, nonatomic) CGFloat notificationHeight;

@end

@implementation ALPHANotificationWindow

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    CGFloat height;
    if (SYSTEM_VERSION_LESS_THAN(@"8.0") && UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
        height = [UIApplication sharedApplication].statusBarFrame.size.width;
    }
    else {
        height = [UIApplication sharedApplication].statusBarFrame.size.height;
    }

    if (point.y > 0 && point.y < (self.notificationHeight != 0.0 ? self.notificationHeight : height)) {
        return [super hitTest:point withEvent:event];
    }

    return nil;
}

@end

#pragma mark - Notification View Controller

@interface ALPHANotificationViewController : UIViewController

@property (nonatomic) UIStatusBarStyle preferredStatusBarStyle;
@property (nonatomic, setter=setSupportedInterfaceOrientations:) NSInteger supportedInterfaceOrientations;

@end

@interface ALPHANotificationViewController ()

@property (nonatomic, assign) NSInteger _alphaViewControllerSupportedInterfaceOrientation;

@end

@implementation ALPHANotificationViewController

@synthesize preferredStatusBarStyle = _preferredStatusBarStyle;

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return _preferredStatusBarStyle;
}

- (void)setSupportedInterfaceOrientations:(NSInteger)supportedInterfaceOrientations
{
    self._alphaViewControllerSupportedInterfaceOrientation = supportedInterfaceOrientations;
}

- (NSInteger)supportedInterfaceOrientations
{
    return self._alphaViewControllerSupportedInterfaceOrientation;
}

- (BOOL)prefersStatusBarHidden
{
    CGFloat statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    return !(statusBarHeight > 0);
}

@end

#pragma mark - Status Bar Notification

@interface ALPHAStatusBarNotification ()

@property (strong, nonatomic) UIView *statusBarView;
@property (strong, nonatomic) UITapGestureRecognizer *tapGestureRecognizer;
@property (strong, nonatomic) ALPHANotificationWindow *notificationWindow;
@property (nonatomic, readwrite) UILabel *notificationLabel;
@property (nonatomic, readwrite) UIView *customView;
@property (strong, nonatomic) ALPHADelayedBlockHandle dismissHandle;
@property (assign, nonatomic) BOOL isCustomView;

@property (nonatomic, readwrite) BOOL isShowing;
@property (nonatomic, readwrite) BOOL isDismissing;

@property (nonatomic) NSInteger supportedInterfaceOrientations;
@property (nonatomic) UIStatusBarStyle preferredStatusBarStyle;

@end

@implementation ALPHAStatusBarNotification

- (ALPHAStatusBarNotification *)init
{
    self = [super init];

    if (self)
    {
        // set defaults
        self.isDismissing = NO;
        self.isCustomView = NO;
        self.preferredStatusBarStyle = UIStatusBarStyleDefault;
        self.supportedInterfaceOrientations = UIInterfaceOrientationMaskAll;

        // create tap recognizer
        self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(notificationTapped:)];
        self.tapGestureRecognizer.numberOfTapsRequired = 1;

        // create default tap block
        __weak typeof(self) weakSelf = self;
        self.notificationTappedBlock = ^(void)
        {
            if (!weakSelf.isDismissing)
            {
                [weakSelf dismissNotification];
            }
        };
    }
    return self;
}

# pragma mark - dimensions

- (CGFloat)getStatusBarHeight
{
    if (self.notificationLabelHeight > 0) {
        return self.notificationLabelHeight;
    }
    CGFloat statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    if (SYSTEM_VERSION_LESS_THAN(@"8.0") && UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
        statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.width;
    }
    return statusBarHeight > 0 ? statusBarHeight : 20;
}

- (CGFloat)getStatusBarWidth
{
    if (SYSTEM_VERSION_LESS_THAN(@"8.0") && UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
        return [UIScreen mainScreen].bounds.size.height;
    }
    return [UIScreen mainScreen].bounds.size.width;
}

- (CGFloat)getStatusBarOffset
{
    if ([self getStatusBarHeight] == 40.0f) {
        return -20.0f;
    }
    return 0.0f;
}

- (CGRect)getNotificationLabelTopFrame
{
    return CGRectMake(0, [self getStatusBarOffset] + -1*[self getNotificationLabelHeight], [self getStatusBarWidth], [self getNotificationLabelHeight]);
}

- (CGRect)getNotificationLabelBottomFrame
{
    return CGRectMake(0, [self getStatusBarOffset] + [self getNotificationLabelHeight], [self getStatusBarWidth], 0);
}

- (CGRect)getNotificationLabelFrame
{
    return CGRectMake(0, [self getStatusBarOffset], [self getStatusBarWidth], [self getNotificationLabelHeight]);
}

- (CGFloat)getNotificationLabelHeight
{
    return [self getStatusBarHeight];
}

# pragma mark - screen orientation change

- (void)updateStatusBarFrame
{
    UIView *view = self.isCustomView ? self.customView : self.notificationLabel;
    view.frame = [self getNotificationLabelFrame];
    self.statusBarView.hidden = YES;
}

# pragma mark - on tap

- (void)notificationTapped:(UITapGestureRecognizer*)recognizer
{
    if (self.notificationTappedBlock)
    {
        self.notificationTappedBlock();
    }
}

# pragma mark - display helpers

- (void)setupNotificationView:(UIView *)view
{
    view.clipsToBounds = YES;
    view.userInteractionEnabled = YES;
    [view addGestureRecognizer:self.tapGestureRecognizer];

    view.frame = [self getNotificationLabelBottomFrame];
}

- (void)createNotificationLabelWithMessage:(NSString *)message
{
    self.notificationLabel = [ALPHANotificationScrollLabel new];
    self.notificationLabel.text = message;
    self.notificationLabel.textAlignment = NSTextAlignmentLeft;
    self.notificationLabel.adjustsFontSizeToFitWidth = NO;
    self.notificationLabel.textColor = [UIColor whiteColor];
    self.notificationLabel.font = [UIFont systemFontOfSize:FONT_SIZE];
    self.notificationLabel.backgroundColor = [[UIApplication sharedApplication] delegate].window.tintColor;
    [self setupNotificationView:self.notificationLabel];
}

- (void)createNotificationCustomView:(UIView *)view
{
    self.customView = [[UIView alloc] init];
    // Doesn't use autoresizing masks so that we can create constraints below manually
    [view setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.customView addSubview:view];

    // Setup Auto Layout constaints so that the custom view that is added is constained to be the same
    // size as its superview, whose frame will be altered
    [self.customView addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.customView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0.0]];
    [self.customView addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.customView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0.0]];
    [self.customView addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.customView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0]];
    [self.customView addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.customView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0]];

    [self setupNotificationView:self.customView];
}

- (void)createNotificationWindow
{
    self.notificationWindow = [[ALPHANotificationWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.notificationWindow.backgroundColor = [UIColor clearColor];
    self.notificationWindow.userInteractionEnabled = YES;
    self.notificationWindow.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.notificationWindow.windowLevel = UIWindowLevelStatusBar + 1000;
    ALPHANotificationViewController *rootViewController = [[ALPHANotificationViewController alloc] init];
    [rootViewController setSupportedInterfaceOrientations:self.supportedInterfaceOrientations];
    rootViewController.preferredStatusBarStyle = self.preferredStatusBarStyle;
    self.notificationWindow.rootViewController = rootViewController;
    self.notificationWindow.notificationHeight = [self getNotificationLabelHeight];
}

- (void)createStatusBarView
{
    self.statusBarView = [[UIView alloc] initWithFrame:[self getNotificationLabelFrame]];
    self.statusBarView.clipsToBounds = YES;
    
    UIView *statusBarImageView = [[UIScreen mainScreen] snapshotViewAfterScreenUpdates:YES];
    [self.statusBarView addSubview:statusBarImageView];
    
    [self.notificationWindow.rootViewController.view addSubview:self.statusBarView];
    [self.notificationWindow.rootViewController.view sendSubviewToBack:self.statusBarView];
}

# pragma mark - frame changing

- (void)firstFrameChange
{
    UIView *view = self.isCustomView ? self.customView : self.notificationLabel;
    view.frame = [self getNotificationLabelFrame];

    self.statusBarView.frame = [self getNotificationLabelTopFrame];
}

- (void)secondFrameChange
{
    UIView *view = self.isCustomView ? self.customView : self.notificationLabel;
    self.statusBarView.frame = [self getNotificationLabelTopFrame];
    view.layer.anchorPoint = CGPointMake(0.5f, 1.0f);
    view.center = CGPointMake(view.center.x, [self getStatusBarOffset] + [self getNotificationLabelHeight]);
}

- (void)thirdFrameChange
{
    UIView *view = self.isCustomView ? self.customView : self.notificationLabel;
    self.statusBarView.frame = [self getNotificationLabelFrame];
    view.transform = CGAffineTransformMakeScale(1.0f, 0.01f);
}

# pragma mark - display notification

- (void)displayNotificationWithMessage:(NSString *)message completion:(void (^)(void))completion
{
    if (!self.isShowing)
    {
        self.isCustomView = NO;
        self.isShowing = YES;

        // create UIWindow
        [self createNotificationWindow];

        // create ScrollLabel
        [self createNotificationLabelWithMessage:message];

        // create status bar view
        [self createStatusBarView];

        // add label to window
        [self.notificationWindow.rootViewController.view addSubview:self.notificationLabel];
        [self.notificationWindow.rootViewController.view bringSubviewToFront:self.notificationLabel];
        [self.notificationWindow setHidden:NO];

        // checking for screen orientation change
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateStatusBarFrame) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];

        // checking for status bar change
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateStatusBarFrame) name:UIApplicationWillChangeStatusBarFrameNotification object:nil];

        // animate
        [UIView animateWithDuration:STATUS_BAR_ANIMATION_LENGTH animations:^{
            [self firstFrameChange];
        } completion:^(BOOL finished) {
            double delayInSeconds = [(ALPHANotificationScrollLabel *)self.notificationLabel scrollTime];
            perform_block_after_delay(delayInSeconds, ^{
                if (completion)
                {
                    completion();
                }
            });
        }];
    }
}

- (void)displayNotificationWithView:(UIView *)view completion:(void (^)(void))completion
{
    if (!self.isShowing) {
        self.isCustomView = YES;
        self.isShowing = YES;

        // create UIWindow
        [self createNotificationWindow];

        // setup view
        [self createNotificationCustomView:view];

        // create status bar view
        [self createStatusBarView];

        // add view to window
        UIView *rootView = self.notificationWindow.rootViewController.view;
        [rootView addSubview:self.customView];
        [rootView bringSubviewToFront:self.customView];
        [self.notificationWindow setHidden:NO];

        // checking for screen orientation change
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateStatusBarFrame) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];

        // checking for status bar change
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateStatusBarFrame) name:UIApplicationWillChangeStatusBarFrameNotification object:nil];

        // animate
        [UIView animateWithDuration:STATUS_BAR_ANIMATION_LENGTH animations:^{
            [self firstFrameChange];
        } completion:^(BOOL finished)
        {
            if (completion)
            {
                completion();
            }
        }];
    }
}

- (void)dismissNotification
{
    [self dismissNotificationWithCompletion:nil];
}

- (void)dismissNotificationWithCompletion:(void (^)(void))completion
{
    if (self.isShowing)
    {
        cancel_delayed_block(self.dismissHandle);
        self.isDismissing = YES;
        [self secondFrameChange];

        [UIView animateWithDuration:STATUS_BAR_ANIMATION_LENGTH animations:^
        {
            [self thirdFrameChange];
        }
        completion:^(BOOL finished)
        {
            UIView *view = self.isCustomView ? self.customView : self.notificationLabel;
            [view removeFromSuperview];
            [self.statusBarView removeFromSuperview];
            [self.notificationWindow setHidden:YES];
            self.notificationWindow = nil;
            view = nil;
            self.isShowing = NO;
            self.isDismissing = NO;

            [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
            [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillChangeStatusBarFrameNotification object:nil];

            if (completion)
            {
                completion();
            }
        }];
    }
    else
    {
        if (completion)
        {
            completion();
        }
    }
}

- (void)displayNotificationWithMessage:(NSString *)message forDuration:(CGFloat)duration
{
    [self displayNotificationWithMessage:message completion:^{
        self.dismissHandle = perform_block_after_delay(duration, ^{
            [self dismissNotification];
        });
    }];
}

- (void)displayNotificationWithView:(UIView *)view forDuration:(CGFloat)duration
{
    [self displayNotificationWithView:view completion:^{
        self.dismissHandle = perform_block_after_delay(duration, ^{
            [self dismissNotification];
        });
    }];
}

@end
