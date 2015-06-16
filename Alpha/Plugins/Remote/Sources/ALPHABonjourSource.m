//
//  ALPHABonjourSource.m
//  Alpha
//
//  Created by Dal Rupnik on 16/06/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import <DTBonjour/DTBonjourDataConnection.h>

#import "ALPHABonjourSource.h"
#import "ALPHANetworkObject.h"

@interface ALPHABonjourSource () <DTBonjourDataConnectionDelegate>

@end

@implementation ALPHABonjourSource

#pragma mark - Getters and Setters

- (void)setConnection:(ALPHABonjourConnection *)connection
{
    _connection = connection;
    connection.delegate = self;
}

#pragma mark - ALPHADataSource

- (void)hasDataForRequest:(ALPHARequest *)request completion:(ALPHADataSourceRequestVerification)completion
{

}

- (void)dataForRequest:(ALPHARequest *)request completion:(ALPHADataSourceRequestCompletion)completion
{

}

- (void)canPerformAction:(id<ALPHAIdentifiableItem>)action completion:(ALPHADataSourceRequestVerification)completion;
{

}

- (void)performAction:(id<ALPHAIdentifiableItem>)action completion:(ALPHADataSourceRequestCompletion)completion
{

}


#pragma mark - DTBonjourDataConnectionDelegate

- (void)connection:(DTBonjourDataConnection *)connection didReceiveObject:(ALPHANetworkObject *)object
{

}

- (void)connectionDidClose:(DTBonjourDataConnection *)connection
{

}

@end
