//
//  ALPHALocalFileSource.m
//  Alpha
//
//  Created by Dal Rupnik on 09/06/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "ALPHALocalFileSource.h"

@implementation ALPHALocalFileSource

- (BOOL)hasDataForRequest:(ALPHARequest *)request
{
    return [request.identifier isEqualToString:ALPHAFileRequestIdentifier];
}

- (void)dataForRequest:(ALPHARequest *)request completion:(ALPHADataSourceCompletion)completion
{
    NSString* url = request.parameters[ALPHAFileURLParameterKey];
    
    NSError *error = nil;
    
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url] options:NSDataReadingMappedIfSafe error:&error];
    
    if (completion)
    {
        completion (data, error);
    }
}

@end
