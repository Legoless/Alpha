//
//  ALPHABonjourServer.m
//  Alpha
//
//  Created by Dal Rupnik on 16/06/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import <Haystack/Haystack.h>

#import <DTBonjour/DTBonjourServer.h>

#import "ALPHABonjourConfig.h"
#import "ALPHANetworkObject.h"

#import "ALPHABonjourServer.h"

@interface ALPHABonjourServer () <DTBonjourServerDelegate>

@property (atomic, strong) DTBonjourServer *server;

@end

@implementation ALPHABonjourServer

- (BOOL)isActive
{
    return self.server.port > 0;
}

- (void)start
{
    self.server = [[DTBonjourServer alloc] initWithBonjourType:ALPHABonjourType];
    self.server.TXTRecord = @{ @"id" : [NSString hs_UUID], @"name" : [[UIDevice currentDevice] name], @"type" : [[UIDevice currentDevice] model], @"system" : [[UIDevice currentDevice] systemName], @"version" : [[UIDevice currentDevice] systemVersion] };
    
    self.server.delegate = self;
    [self.server start];
}

- (void)stop
{
    [self.server stop];
    
    self.server = nil;
}

#pragma mark - DTBonjourServerDelegate

- (void)bonjourServer:(DTBonjourServer *)server didAcceptConnection:(DTBonjourDataConnection *)connection
{
    NSLog(@"SERVER ACCEPTED CONNECTION: %@", connection);
}

- (void)bonjourServer:(DTBonjourServer *)server didReceiveObject:(ALPHANetworkObject *)object onConnection:(DTBonjourDataConnection *)connection
{
    //
    // We had received an object, we assume it is bonjour object, but make a check to prevent crashing.
    //
    
    NSLog(@"SERVER RECEIVING OBJECT: %@ CONN: %@", object, connection);
    
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


@end
