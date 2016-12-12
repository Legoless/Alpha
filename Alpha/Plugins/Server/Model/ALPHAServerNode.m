//
//  ALPHABonjourServer.m
//  Alpha
//
//  Created by Dal Rupnik on 16/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHABonjourServer.h"

#import "NSString+Random.h"

#import "ALPHABonjourConfig.h"
#import "ALPHANetworkObject.h"

#import "ALPHAServerNode.h"

#import "ALPHAManager.h"

@interface ALPHAServerNode () <ALPHABonjourServerDelegate>

@property (atomic, strong) ALPHABonjourServer *server;

@property (nonatomic, strong) ALPHAStatusBarNotification *notification;

@end

@implementation ALPHAServerNode

- (BOOL)isActive
{
    return self.server.port > 0;
}

- (void)start
{
    self.server = [[ALPHABonjourServer alloc] initWithBonjourType:ALPHABonjourType];
    self.server.TXTRecord = @{ @"id" : [NSString alpha_UUID], @"name" : [[UIDevice currentDevice] name], @"type" : [[UIDevice currentDevice] model], @"system" : [[UIDevice currentDevice] systemName], @"version" : [[UIDevice currentDevice] systemVersion] };
    
    self.server.delegate = self;
    [self.server start];
    
    self.notification = [[ALPHAManager defaultManager] displayNotificationWithMessage:[self serverStatusText] completion:nil];
}

- (void)stop
{
    [self.server stop];
    
    self.server = nil;
    
    [self.notification dismissNotificationWithCompletion:^
    {
        self.notification = nil;
    }];
}

#pragma mark - ALPHABonjourServerDelegate

- (void)bonjourServer:(ALPHABonjourServer *)server didAcceptConnection:(ALPHABonjourDataConnection *)connection
{
    self.notification.notificationLabel.text = [self serverStatusText];
}

- (void)bonjourServer:(ALPHABonjourServer *)server didReceiveObject:(ALPHANetworkObject *)object onConnection:(ALPHABonjourDataConnection *)connection
{
    //
    // We had received an object, we assume it is bonjour object, but make a check to prevent crashing.
    //
    
    //NSLog(@"SERVER RECEIVING OBJECT: %@ CONN: %@", object, connection);
    
    if (![object isKindOfClass:[ALPHANetworkObject class]] || !self.source)
    {
        return;
    }
    
    id<ALPHASerializableItem> item = [object object];
    
    //
    // Connect with data source
    //
    if ([item isKindOfClass:[ALPHARequest class]])
    {
        ALPHARequest *request = (ALPHARequest *)item;
        
        //
        // Check if it is only for a hasData request
        //
        
        if (object.parameters[ALPHANetworkObjectVerificationKey])
        {
            [self.source hasDataForRequest:request completion:^(BOOL result)
            {
                ALPHANetworkObject *bonjour = [[ALPHANetworkObject alloc] init];
                bonjour.parameters = @{ ALPHANetworkObjectVerificationKey : @(result) };
                
                [connection sendObject:bonjour error:nil];
            }];
        }
        else
        {
            [self.source dataForRequest:request completion:^(id object, NSError *error)
            {
                ALPHANetworkObject *bonjour = [[ALPHANetworkObject alloc] init];
                bonjour.object = object;
                 
                if (error)
                {
                    bonjour.error = error;
                }
                 
                [connection sendObject:bonjour error:nil];
            }];
        }
    }
    else if ([item conformsToProtocol:@protocol(ALPHAIdentifiableItem)])
    {
        id<ALPHAIdentifiableItem> action = (id<ALPHAIdentifiableItem>)item;
        
        if (object.parameters[ALPHANetworkObjectVerificationKey])
        {
            [self.source canPerformAction:action completion:^(BOOL result)
            {
                ALPHANetworkObject *bonjour = [[ALPHANetworkObject alloc] init];
                bonjour.parameters = @{ ALPHANetworkObjectVerificationKey : @(result) };
                
                [connection sendObject:bonjour error:nil];
            }];
        }
        else
        {
            [self.source performAction:action completion:^(id object, NSError *error)
            {
                ALPHANetworkObject *bonjour = [[ALPHANetworkObject alloc] init];
                bonjour.object = object;
                
                if (error)
                {
                    bonjour.error = error;
                }
                
                [connection sendObject:bonjour error:nil];
            }];
        }
    }
}

#pragma mark - Private methods

- (NSString *)serverStatusText
{
    return [NSString stringWithFormat:@"Bonjour Server Active: %ld - Connected", (long)self.server.connections.count];
}

@end
