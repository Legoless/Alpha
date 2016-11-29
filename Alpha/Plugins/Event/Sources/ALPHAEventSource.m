//
//  ALPHAEventSource.m
//  Alpha
//
//  Created by Dal Rupnik on 08/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "NSInvocation+Argument.h"

#import "ALPHAEventSource.h"
#import "ALPHAEventModel.h"
#import "ALPHAApplicationDelegate.h"

NSString *const ALPHAEventDataIdentifier = @"com.unifiedsense.alpha.data.event";

@interface ALPHAEventSource ()

@property (nonatomic, strong) NSMutableArray *events;

@end

@implementation ALPHAEventSource

#pragma mark - Getters and Setters

- (NSMutableArray *)events
{
    if (!_events)
    {
        _events = [NSMutableArray array];
    }
    
    return _events;
}

+ (instancetype)sharedSource
{
    static id sharedCollector = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedCollector = [[[self class] alloc] init];
    });
    return sharedCollector;
}

#pragma mark - Initialization

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(delegateEvent:) name:ALPHAApplicationDelegateNotification object:nil];
        
        [self addDataIdentifier:ALPHAEventDataIdentifier];
    }
    
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Public methods

- (void)addEvent:(ALPHAApplicationEvent *)event
{
    if (event.name.length)
    {
        [self.events addObject:event];
    }
}

#pragma mark - ALPHABaseDataSource

- (ALPHAModel *)modelForRequest:(ALPHARequest *)request
{
    ALPHAEventModel *model = [[ALPHAEventModel alloc] initWithIdentifier:ALPHAEventDataIdentifier];
    model.events = self.events.copy;
    
    return model;
}

#pragma mark - Private Methods

- (void)delegateEvent:(NSNotification *)notification
{
    NSInvocation *anInvocation = notification.object;
    
    ALPHAApplicationEvent *event = [[ALPHAApplicationEvent alloc] init];
    
    event.name = [self eventNameForSelector:anInvocation.selector];
    
    if (event.name)
    {
        event.name = [NSString stringWithFormat:@"App %@", event.name];
    }
    
    event.sender = NSStringFromSelector(anInvocation.selector);
    
    if (anInvocation.selector == @selector(application:didFinishLaunchingWithOptions:))
    {
        // Launched with options, 0 - self, 1 - _cmd, 2 - UIApplication, 3 - options
        event.info = [anInvocation alpha_objectAtIndex:3];
    }
    
    [self addEvent:event];
}

- (NSString *)eventNameForSelector:(SEL)selector
{
    if (selector == @selector(applicationDidFinishLaunching:))
    {
        return @"Launched";
    }
    else if (selector == @selector(application:didFinishLaunchingWithOptions:))
    {
        return @"Launched with Options";
    }
    else if (selector == @selector(applicationDidReceiveMemoryWarning:))
    {
        return @"Memory warning";
    }
    else if (selector == @selector(applicationDidBecomeActive:))
    {
        return @"Activated";
    }
    else if (selector == @selector(applicationDidEnterBackground:))
    {
        return @"Entered Background";
    }
    else if (selector == @selector(applicationProtectedDataDidBecomeAvailable:))
    {
        return @"Protected Data Available";
    }
    else if (selector == @selector(applicationWillResignActive:))
    {
        return @"Resigned Active";
    }
    else if (selector == @selector(applicationWillEnterForeground:))
    {
        return @"Will Enter Foreground";
    }
    
    if (selector != NULL)
    {
        return NSStringFromSelector(selector);
    }
    
    return nil;
}

@end
