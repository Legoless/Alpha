//
//  ALPHABonjourServer.m
//  Alpha
//
//  Created by Dal Rupnik on 16/06/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import <DTBonjour/DTBonjourServer.h>

#import "ALPHABonjourConfig.h"
#import "ALPHABonjourObject.h"
#import "ALPHABonjourServer.h"

@interface ALPHABonjourServer () <DTBonjourServerDelegate>

@property (atomic, strong) DTBonjourServer *server;

@end

@implementation ALPHABonjourServer

- (void)start
{
    self.server = [[DTBonjourServer alloc] initWithBonjourType:ALPHABonjourType];
    [self.server start];
}

- (void)stop
{
    [self.server stop];
    
    self.server = nil;
}

#pragma mark - DTBonjourServerDelegate

- (void)bonjourServer:(DTBonjourServer *)server didReceiveObject:(ALPHABonjourObject *)object onConnection:(DTBonjourDataConnection *)connection
{
    //
    // We had received an object, we assume it is bonjour object, but make a check to prevent crashing.
    //
    
    if (![object isKindOfClass:[ALPHABonjourObject class]] || !self.source)
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
        
        if ([self.source hasDataForRequest:request])
        {
            [self.source dataForRequest:request completion:^(id object, NSError *error)
            {
                ALPHABonjourObject *bonjour = [[ALPHABonjourObject alloc] initWithObject:object];
                
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
        
        if ([self.source canPerformAction:action])
        {
            [self.source performAction:action completion:^(id object, NSError *error)
            {
                ALPHABonjourObject *bonjour = [[ALPHABonjourObject alloc] initWithObject:object];
                
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
