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

@property (nonatomic, copy) ALPHADataSourceRequestCompletion completion;
@property (nonatomic, copy) ALPHADataSourceRequestVerification verification;

@end

@implementation ALPHABonjourSource

#pragma mark - Getters and Setters

- (void)setConnection:(ALPHABonjourConnection *)connection
{
    _connection = connection;
    connection.delegate = self;
}

#pragma mark - Initialziation

- (instancetype)initWithConnection:(ALPHABonjourConnection *)connection
{
    self = [super init];
    
    if (self)
    {
        self.connection = connection;
    }
    
    return self;
}

#pragma mark - ALPHADataSource

- (void)hasDataForRequest:(ALPHARequest *)request completion:(ALPHADataSourceRequestVerification)completion
{
    ALPHANetworkObject* object = [[ALPHANetworkObject alloc] initWithObject:request];
    object.parameters = @{ ALPHANetworkObjectVerificationKey : @(YES) };
    
    self.verification = completion;
    
    NSError* error = nil;
    
    [self.connection sendObject:object error:&error];
    
    if (error)
    {
        NSLog(@"Error sending object: %@", error);
        
        if (completion)
        {
            completion(NO);
        }
    }
}

- (void)dataForRequest:(ALPHARequest *)request completion:(ALPHADataSourceRequestCompletion)completion
{
    ALPHANetworkObject* object = [[ALPHANetworkObject alloc] initWithObject:request];
    
    self.completion = completion;
    
    NSError* error = nil;
    
    [self.connection sendObject:object error:&error];
    
    if (error)
    {
        NSLog(@"Error sending object: %@", error);
        
        if (completion)
        {
            completion(nil, error);
        }
    }

}

- (void)canPerformAction:(id<ALPHAIdentifiableItem>)action completion:(ALPHADataSourceRequestVerification)completion;
{
    ALPHANetworkObject* object = [[ALPHANetworkObject alloc] initWithObject:action];
    object.parameters = @{ ALPHANetworkObjectVerificationKey : @(YES) };
    
    self.verification = completion;
    
    NSError* error = nil;
    
    [self.connection sendObject:object error:&error];
    
    if (error)
    {
        NSLog(@"Error sending object: %@", error);
        
        if (completion)
        {
            completion(NO);
        }
    }

}

- (void)performAction:(id<ALPHAIdentifiableItem>)action completion:(ALPHADataSourceRequestCompletion)completion
{
    ALPHANetworkObject* object = [[ALPHANetworkObject alloc] initWithObject:action];
    
    self.completion = completion;
    
    NSError* error = nil;
    
    [self.connection sendObject:object error:&error];
    
    if (error)
    {
        NSLog(@"Error sending object: %@", error);
        
        if (completion)
        {
            completion(nil, error);
        }
    }
}

#pragma mark - DTBonjourDataConnectionDelegate

- (void)connection:(DTBonjourDataConnection *)connection didReceiveObject:(ALPHANetworkObject *)object
{
    //
    // Check if it errored
    //
    
    id serializedObject = object.object;
    
    if (object.error)
    {
        if (self.verification)
        {
            self.verification(NO);
        }
        else if (self.completion)
        {
            self.completion (nil, object.error);
        }
    }
    else if (object.parameters[ALPHANetworkObjectVerificationKey] && self.verification)
    {
        self.verification ([object.parameters[ALPHANetworkObjectVerificationKey] boolValue]);
    }
    else if (serializedObject && self.completion)
    {
        self.completion (serializedObject, nil);
    }
    
    self.verification = nil;
    self.completion = nil;
}

- (void)connectionDidClose:(DTBonjourDataConnection *)connection
{
    self.connection = nil;
    
    self.verification = nil;
    self.completion = nil;
}

#pragma mark - Private methods

- (void)verificationComplete:(ALPHADataSourceRequestVerification)completion
{
    
}

- (void)requestComplete:(ALPHADataSourceRequestCompletion)completion
{
    
}

@end
