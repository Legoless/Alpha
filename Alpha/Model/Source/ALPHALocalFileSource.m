//
//  ALPHALocalFileSource.m
//  Alpha
//
//  Created by Dal Rupnik on 09/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHARuntimeUtility.h"
#import "ALPHALocalFileSource.h"

@implementation ALPHALocalFileSource

- (void)hasDataForRequest:(ALPHARequest *)request completion:(ALPHADataSourceRequestVerification)completion
{
    if (!completion)
    {
        return;
    }
    
    completion ([request.identifier isEqualToString:ALPHAFileRequestIdentifier]);
}

- (void)dataForRequest:(ALPHARequest *)request completion:(ALPHADataSourceRequestCompletion)completion
{
    NSString* url = request.parameters[ALPHAFileURLParameterKey];
    
    NSError *error = nil;
    
    id data = nil;
    
    NSString* fileClass = request.parameters[ALPHAFileClassParameterKey];
    
    //
    // If request has no aspecified file class, we try to guess what file it is based on extension
    //
    
    if (!fileClass)
    {
        if ([ALPHARuntimeUtility isImagePathExtension:[url pathExtension]])
        {
            fileClass = @"UIImage";
        }
        else
        {
            if ([[url pathExtension] isEqual:@"archive"])
            {
                fileClass = @"NSString";
            }
            else if ([[url pathExtension] isEqualToString:@"json"])
            {
                fileClass = @"NSString";
            }
            else if ([[url pathExtension] isEqualToString:@"plist"])
            {
                fileClass = @"NSString";
            }
        }
    }
    
    data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url] options:NSDataReadingMappedIfSafe error:&error];
    
    if (fileClass && !error)
    {
        Class class = NSClassFromString(fileClass);
        
        if (class == [UIImage class])
        {
            data = [[UIImage alloc] initWithData:data];
        }
        else
        {
            if ([[url pathExtension] isEqual:@"archive"])
            {
                data = [[NSKeyedUnarchiver unarchiveObjectWithData:data] description];
            }
            else if ([[url pathExtension] isEqualToString:@"json"])
            {
                id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                data = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:jsonObject options:NSJSONWritingPrettyPrinted error:&error] encoding:NSUTF8StringEncoding];
            }
            else if ([[url pathExtension] isEqualToString:@"plist"])
            {
                data = [[NSPropertyListSerialization propertyListWithData:data options:0 format:NULL error:&error] description];
            }
        }
    }
    
    if (!data)
    {
        data = [NSURL URLWithString:url];
    }
    
    if (completion)
    {
        completion (data, error);
    }
}

@end
