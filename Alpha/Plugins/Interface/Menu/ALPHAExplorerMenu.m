//
//  ALPHAExplorerMenu.m
//  Alpha
//
//  Created by Dal Rupnik on 21/11/14.
//  Copyright © 2014 Unified Sense. All rights reserved.
//

#import <math.h>

#import "ALPHACircleMenuView.h"
#import "ALPHAMenuCenterView.h"

#import "CGVectorAdditions.h"

#import "ALPHAExplorerMenu.h"

@interface ALPHAExplorerMenu () <ALPHACircleMenuDelegate>

//
// UI Elements
//

@property (nonatomic, strong) ALPHACircleMenuView *circleMenuView;

@property (nonatomic, strong) NSDate* menuOpenDate;

@property (nonatomic) NSMutableArray* buttons;

@property (nonatomic, strong) ALPHAMenuCenterView* centerView;

@property (nonatomic) CGFloat angle;
@property (nonatomic) CGFloat delay;
@property (nonatomic) int shadow;
@property (nonatomic) CGFloat radius;
@property (nonatomic) CGFloat buttonRadius;
@property (nonatomic) int direction;
@property (nonatomic, strong) UILongPressGestureRecognizer* longPressRecognizer;
@property (nonatomic, strong) UILongPressGestureRecognizer* longPressMenuRecognizer;

@end


@implementation ALPHAExplorerMenu

#pragma mark - Getters and Setters

- (void)setMainBackgroundColor:(UIColor *)mainBackgroundColor
{
    _mainBackgroundColor = mainBackgroundColor;
    
    self.centerView.mainBackgroundColor = mainBackgroundColor;
}

- (UIColor *)buttonBackgroundColor
{
    if (!_buttonBackgroundColor)
    {
        return [UIColor blackColor];
    }
    
    return _buttonBackgroundColor;
}

- (UIColor *)buttonSelectedBackgroundColor
{
    if (!_buttonSelectedBackgroundColor)
    {
        return [UIColor colorWithWhite:0.6 alpha:1.0];
    }
    
    return _buttonSelectedBackgroundColor;
}

- (void)setTintColor:(UIColor *)tintColor
{
    [super setTintColor:tintColor];
    
    self.centerView.tintColor = tintColor;
}

- (void)setMainImage:(UIImage *)mainImage
{
    _mainImage = mainImage;
    
    self.centerView.image = mainImage;
}

#pragma mark - UIView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setup];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        [self setup];
    }
    
    return self;
}

- (void)setup
{
    self.longPressMenuRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleMenuTap:)];
    self.longPressMenuRecognizer.minimumPressDuration = 0.3;
    
    self.direction = ALPHACircleMenuDirectionRight;
    self.delay = 0.0;
    self.buttonRadius = 26.0;
    self.shadow = 0;
    self.radius = 80.0;
    self.angle = 90.0;
    
    self.backgroundColor = [UIColor clearColor];
    
    self.centerView = [[ALPHAMenuCenterView alloc] initWithFrame:self.bounds];
    self.centerView.mainBackgroundColor = self.mainBackgroundColor;
    
    [self addSubview:self.centerView];
    
    [self addGestureRecognizer:self.longPressMenuRecognizer];
}

- (void)setSnapToBorder:(BOOL)snapToBorder
{
    _snapToBorder = snapToBorder;
    
    [self moveToLocationWithSnap];
}

- (void)handleMenuDrag:(UIGestureRecognizer *)recognizer
{
    //NSLog(@"MENU DRAG!");
    
    CGFloat increaseFactor = 1.5;
    
    CGPoint location = [recognizer locationInView:self.superview];
    
    if (CGAffineTransformIsIdentity(self.centerView.transform))
    {
        [UIView animateWithDuration:0.2 animations:^
        {
            self.centerView.transform = CGAffineTransformMakeScale(increaseFactor, increaseFactor);
            self.center = location;
        }];
    }
    else
    {
        CGFloat sizeX = (self.bounds.size.width) / 2.0;
        CGFloat sizeY = (self.bounds.size.height) / 2.0;
        
        if (location.x < sizeX)
        {
            location.x = sizeX;
        }
        
        if (location.x > self.superview.bounds.size.width - sizeX)
        {
            location.x = self.superview.bounds.size.width - sizeX;
        }
        
        if (location.y < sizeY)
        {
            location.y = sizeY;
        }
        
        if (location.y > self.superview.bounds.size.height - sizeY)
        {
            location.y = self.superview.bounds.size.height - sizeY;
        }
        
        self.center = location;
            
        [self updateContextPosition];
    }
    
    /*if (self.circleMenuView)
    {
        [self.circleMenuView closeMenu];
        self.circleMenuView = nil;
    }*/
}

- (void)moveToLocationWithSnap
{
    //
    // Check for snap to border
    //
    if (!self.snapToBorder || CGRectIsEmpty(self.superview.bounds))
    {
        return;
    }
    
    //
    // Find closest border
    //

    int typeX = 0;
    int typeY = 0;
    
    CGPoint min = CGPointZero;
    
    CGPoint location = self.center;
    
    CGFloat radius = self.bounds.size.width / 2.0;
    
    if (location.x < self.superview.bounds.size.width / 2.0)
    {
        // Left border
        typeX = 0;
        
        min.x = location.x;
    }
    else
    {
        // Right border
        typeX = 1;
        
        min.x = self.superview.bounds.size.width - location.x;
    }
    
    //
    // Check for height
    //
    
    if (location.y < self.superview.bounds.size.height / 2.0)
    {
        // Top border
        typeY = 0;
        
        min.y = location.y;
    }
    else
    {
        // Bottom border
        typeY = 1;
        
        min.y = self.superview.bounds.size.height - location.y;
    }
    
    //
    // Decide axis
    //
    
    if (min.x < min.y)
    {
        // Leave y axis in peace
        min.y = location.y;
        
        min.x = typeX ? self.superview.bounds.size.width - radius : radius;
    }
    else
    {
        min.x = location.x;
        
        min.y = typeY ? self.superview.bounds.size.height - radius : radius;
    }
    
    self.center = min;
    
    //NSLog(@"Moving to: %@", NSStringFromCGPoint(min));
    
    [self updateContextPosition];
}

- (void)handleMenuTap:(UIGestureRecognizer *)recognizer
{
    //NSLog(@"Recognizer state: %d", recognizer.state);
    
    if (recognizer.state == UIGestureRecognizerStateBegan)
    {
        CGPoint tPoint = CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0);

        self.circleMenuView = [[ALPHACircleMenuView alloc] initAtOrigin:tPoint usingOptions:[self optionsDictionary] withImageArray:self.images];
        [self addSubview:self.circleMenuView];
        
        self.circleMenuView.delegate = self;
        
        [self.circleMenuView openMenuWithRecognizer:recognizer];
        
        self.menuOpenDate = [NSDate date];
        
        self.centerView.image = self.mainImage;
        
        [self updateContextPosition];
    }
    else if (recognizer.state == UIGestureRecognizerStateChanged)
    {
        CGPoint tPoint = [recognizer locationInView:self];
        
        if (fabs([self.menuOpenDate timeIntervalSinceNow]) > 1.0 && (CGRectContainsPoint(self.bounds, tPoint)) )
        {
            [self handleMenuDrag:recognizer];
        }
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded)
    {
        self.menuOpenDate = nil;
        
        self.centerView.image = self.mainImage;
        
        [UIView animateWithDuration:0.2 animations:^
        {
            self.centerView.transform = CGAffineTransformIdentity;
            [self moveToLocationWithSnap];
        }];
    }
}

#pragma mark - CKCircleMenuDelegate

- (void)circleMenuActivatedButtonWithIndex:(int)anIndex
{
    if ([self.delegate respondsToSelector:@selector(explorerMenu:didSelectImage:)])
    {
        [self.delegate explorerMenu:self didSelectImage:self.images[anIndex]];
    }
}

- (void)circleMenuHoverOnButtonWithIndex:(int)anIndex
{
    UIImage* image = nil;
    
    if (anIndex >= 0 && anIndex < self.images.count)
    {
        image = self.images[anIndex];
        
        self.menuOpenDate = [NSDate date];
    }
    
    if (!image)
    {
        image = self.mainImage;
    }
    
    self.centerView.image = image;
}

#pragma mark - Update menu angle

- (void)updateContextPosition
{
    CGFloat radius = self.radius + self.buttonRadius;
    
    ALPHACircleMenuDirection axisXClosestBorder = ALPHACircleMenuDirectionLeft;
    CGFloat axisXDistance = self.center.x;
    
    if (self.superview.bounds.size.width - self.center.x < self.center.x)
    {
        axisXClosestBorder = ALPHACircleMenuDirectionRight;
        axisXDistance = self.superview.bounds.size.width - self.center.x;
    }
    
    ALPHACircleMenuDirection axisYClosestBorder = ALPHACircleMenuDirectionUp;
    CGFloat axisYDistance = self.center.y;
    
    if (self.superview.bounds.size.height - self.center.y < self.center.y)
    {
        axisYClosestBorder = ALPHACircleMenuDirectionDown;
        axisYDistance = self.superview.bounds.size.height - self.center.y;
    }
    
    CGPoint topRight = CGPointMake(self.superview.bounds.size.width, 0.0);
    CGPoint bottomRight = CGPointMake(self.superview.bounds.size.width, self.superview.bounds.size.height);
    CGPoint topLeft = CGPointZero;
    CGPoint bottomLeft = CGPointMake(0.0, self.superview.bounds.size.height);
    
    CGPoint menuCenter = self.center;
    
    NSArray* pointsLeft = [self pointsAtIntersectWithLineFromOrigin:topLeft toTarget:bottomLeft withCenter:menuCenter withRadius:radius];
    NSArray* pointsRight = [self pointsAtIntersectWithLineFromOrigin:topRight toTarget:bottomRight withCenter:menuCenter withRadius:radius];
    
    NSArray* pointsTop = [self pointsAtIntersectWithLineFromOrigin:topLeft toTarget:topRight withCenter:menuCenter withRadius:radius];
    
    NSArray* pointsBottom = [self pointsAtIntersectWithLineFromOrigin:bottomLeft toTarget:bottomRight withCenter:menuCenter withRadius:radius];
    
    CGFloat leftAngle = [self checkAndCalculateAngleBetweenPoints:pointsLeft center:menuCenter];
    CGFloat rightAngle = [self checkAndCalculateAngleBetweenPoints:pointsRight center:menuCenter];
    CGFloat topAngle = [self checkAndCalculateAngleBetweenPoints:pointsTop center:menuCenter];
    CGFloat bottomAngle = [self checkAndCalculateAngleBetweenPoints:pointsBottom center:menuCenter];
    
    //NSLog(@"Left: %f", leftAngle);
    //NSLog(@"Right: %f", rightAngle);
    //NSLog(@"Top: %f", topAngle);
    //NSLog(@"Bottom: %f", bottomAngle);
    
    //
    // Calculate available angle
    //
    
    CGFloat totalAngle = 90.0;
    
    /*
    totalAngle -= ( (90.0 - leftAngle) * 2.0);
    totalAngle -= ( (90.0 - rightAngle) * 2.0);
    totalAngle -= ( (90.0 - topAngle) * 2.0);
    totalAngle -= ( (90.0 - bottomAngle) * 2.0);
     */
    
    //
    // Factorizes angle because of menu buttons extending.
    //
    CGFloat angleModifier = 1.0;
    
    //
    // Set menu to open in correct way
    //
    
    if (leftAngle < 90.0 && topAngle < 90.0)
    {
        self.direction = ALPHACircleMenuDirectionDown;
        
        totalAngle += leftAngle + topAngle;
        
        angleModifier = 0.85;
    }
    else if (leftAngle < 90.0 && bottomAngle < 90.0)
    {
        self.direction = ALPHACircleMenuDirectionRight;
        
        totalAngle += leftAngle + bottomAngle;
        
        angleModifier = 0.85;
    }
    else if (rightAngle < 90.0 && topAngle < 90.0)
    {
        self.direction = ALPHACircleMenuDirectionLeft;
        
        totalAngle += rightAngle + topAngle;
        
        angleModifier = 0.85;
    }
    else if (rightAngle < 90.0 && bottomAngle < 90.0)
    {
        self.direction = ALPHACircleMenuDirectionUp;
        
        totalAngle += rightAngle + bottomAngle;
        
        angleModifier = 0.85;
    }
    else if (rightAngle < 90.0)
    {
        self.direction = ALPHACircleMenuDirectionLeft;
        
        totalAngle = 360.0 - (2 * (90.0 - rightAngle));
        
        //angleModifier = 0.95;
    }
    else if (leftAngle < 90.0)
    {
        self.direction = ALPHACircleMenuDirectionRight;
        
        totalAngle = 360.0 - (2 * (90.0 - leftAngle));
        
        //angleModifier = 0.95;
    }
    else if (topAngle < 90.0)
    {
        self.direction = ALPHACircleMenuDirectionDown;
        
        totalAngle = 360.0 - (2 * (90.0 - topAngle));
        
        //angleModifier = 0.95;
    }
    else if (bottomAngle < 90.0)
    {
        totalAngle = 360.0 - (2 * (90.0 - bottomAngle));
        
        //angleModifier = 0.95;
        
        self.direction = ALPHACircleMenuDirectionUp;
    }
    else
    {
        totalAngle = 360.0;
        
        //self.direction = ALPHACircleMenuDirectionUp;
    }
    
    totalAngle *= angleModifier;
    
    self.angle = totalAngle;
    
    //NSLog(@"Total: %f", totalAngle);
    
    [self bringSubviewToFront:self.centerView];
    
    [UIView animateWithDuration:0.2 animations:^{
        [self.circleMenuView updateWithOptions:[self optionsDictionary]];
    }];
    
}

- (NSDictionary *)optionsDictionary
{
    NSMutableDictionary* tOptions = [NSMutableDictionary new];
    [tOptions setValue:[NSDecimalNumber numberWithFloat:self.delay] forKey:CIRCLE_MENU_OPENING_DELAY];
    [tOptions setValue:[NSDecimalNumber numberWithFloat:self.angle] forKey:CIRCLE_MENU_MAX_ANGLE];
    [tOptions setValue:[NSDecimalNumber numberWithFloat:self.radius] forKey:CIRCLE_MENU_RADIUS];
    [tOptions setValue:[NSNumber numberWithInt:self.direction] forKey:CIRCLE_MENU_DIRECTION];

    [tOptions setValue:[NSNumber numberWithInt:self.shadow] forKey:CIRCLE_MENU_DEPTH];
    [tOptions setValue:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f", self.buttonRadius]] forKey:CIRCLE_MENU_BUTTON_RADIUS];
    [tOptions setValue:[NSDecimalNumber decimalNumberWithString:@"2.5"] forKey:CIRCLE_MENU_BUTTON_BORDER_WIDTH];
    
    //
    // Colors
    //
    [tOptions setValue:self.buttonBackgroundColor forKey:CIRCLE_MENU_BUTTON_BACKGROUND_NORMAL];
    [tOptions setValue:self.buttonSelectedBackgroundColor forKey:CIRCLE_MENU_BUTTON_BACKGROUND_ACTIVE];
    [tOptions setValue:self.tintColor forKey:CIRCLE_MENU_BUTTON_BORDER];
    
    return [tOptions copy];
}

#pragma mark - Math (refactor to Haystack later on)

- (CGFloat)checkAndCalculateAngleBetweenPoints:(NSArray *)points center:(CGPoint)center
{
    if (points.count == 2)
    {
        NSArray *angles = [self anglesBetweenPointA:[points[0] CGPointValue] pointB:[points[1] CGPointValue] pointC:center];
        
        return [[angles firstObject] doubleValue];
    }
    
    return 90.0;
}

- (NSArray *)pointsAtIntersectWithLineFromOrigin:(CGPoint)origin toTarget:(CGPoint)target withCenter:(CGPoint)center withRadius:(double)radius
{
    CGFloat euclideanAtoB = sqrt(pow(target.x - origin.x, 2.0) + pow(target.y - origin.y, 2.0));
    
    CGVector d = CGVectorMake( (target.x - origin.x) / euclideanAtoB, (target.y - origin.y) / euclideanAtoB);
    
    CGFloat t = (d.dx * (center.x - origin.x)) + (d.dy * (center.y - origin.y));
    
    CGPoint e = CGPointZero;
    
    e.x = (t * d.dx) + origin.x;
    e.y = (t * d.dy) + origin.y;
    
    CGFloat euclideanCtoE = sqrt(pow(e.x - center.x, 2.0) + pow(e.y - center.y, 2.0));
    
    if (euclideanCtoE < radius)
    {
        CGFloat dt = sqrt (pow(radius, 2.0) - pow(euclideanCtoE, 2.0));
        
        CGPoint f = CGPointZero;
        f.x = ((t - dt) * d.dx) + origin.x;
        f.y = ((t - dt) * d.dy) + origin.y;
        
        CGPoint g = CGPointZero;
        g.x = ((t + dt) * d.dx) + origin.x;
        g.y = ((t + dt) * d.dy) + origin.y;

        NSMutableArray *points = [NSMutableArray array];
        
        [points addObject:[NSValue valueWithCGPoint:f]];
        [points addObject:[NSValue valueWithCGPoint:g]];
        
        if (![self point:f isOnLineFromPointA:origin toPointB:target])
        {
           
        }
        
        if (![self point:g isOnLineFromPointA:origin toPointB:target])
        {
            
        }
        
        return [points copy];
    }
    else if (fabs(euclideanCtoE - radius) < DBL_EPSILON)
    {
        return @[];
    }
    
    return nil;
}
    
- (CGFloat)distanceFromPoint:(CGPoint)a toPointB:(CGPoint)b
{
    return sqrt(pow(a.x - b.x, 2.0) + pow(a.y - b.y, 2.0));
}

- (BOOL)point:(CGPoint)c isOnLineFromPointA:(CGPoint)a toPointB:(CGPoint)b
{
    return [self distanceFromPoint:a toPointB:c] + [self distanceFromPoint:c toPointB:b] == [self distanceFromPoint:a toPointB:b];
}

- (NSArray *)anglesBetweenPointA:(CGPoint)a pointB:(CGPoint)b pointC:(CGPoint)c
{
    CGFloat angleAB = atan2(b.y - a.y, b.x - a.x);
    CGFloat angleAC = atan2(c.y - a.y, c.x - a.x);
    CGFloat angleBC = atan2(b.y - c.y, b.x - c.x);
    
    CGFloat angleA = fabs((angleAB - angleAC) * (180 / M_PI));
    CGFloat angleB = fabs((angleAB - angleBC) * (180 / M_PI));
    
    return @[ @(angleA), @(angleB) ];
}

@end
