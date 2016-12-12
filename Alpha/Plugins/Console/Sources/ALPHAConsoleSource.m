//
//  ALPHAConsoleSource.m
//  Alpha
//
//  Created by Dal Rupnik on 10/11/14.
//  Copyright © 2014 Unifed Sense. All rights reserved.
//

#import <asl.h>
#import <os/log.h>

#import "ALPHAConsoleLog.h"
#import "ALPHAConsoleModel.h"

#import "ALPHAConsoleSource.h"

NSString *const ALPHAConsoleDataIdentifier = @"com.unifiedsense.alpha.data.console";

@interface ALPHAConsoleSource ()

@end

@implementation ALPHAConsoleSource

- (NSArray *)systemLogs {
    NSMutableArray* logs = [NSMutableArray array];
    
    //
    // http://www.cocoanetics.com/2011/03/accessing-the-ios-system-log/
    //
    aslmsg q, m;
    int i;
    const char *key, *val;
    
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Wdeprecated-declarations"
    
    q = asl_new(ASL_TYPE_QUERY);
    
    aslresponse r = asl_search(NULL, q);
    while (NULL != (m = asl_next(r))) {
        NSMutableDictionary *tmpDict = [NSMutableDictionary dictionary];
        
        for (i = 0; (NULL != (key = asl_key(m, i))); i++) {
            NSString *keyString = [NSString stringWithUTF8String:(char *)key];
            
            val = asl_get(m, key);
            
            NSString *string = val ? [NSString stringWithUTF8String:val] : @"";
            [tmpDict setObject:string forKey:keyString];
        }
        
        ALPHAConsoleLog* log = [[ALPHAConsoleLog alloc] initWithDictionary:tmpDict];
        
        if (log) {
            [logs addObject:log];
        }
    }
    asl_release(r);
    
    #pragma clang diagnostic pop
    
    return [logs copy];
}

- (NSArray *)systemLogsOS {
    
    NSMutableArray* logs = [NSMutableArray array];
    
    return [logs copy];
}

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        [self addDataIdentifier:ALPHAConsoleDataIdentifier];
    }
    
    return self;
}

- (ALPHAModel *)modelForRequest:(ALPHARequest *)request
{
    ALPHAConsoleModel* model = [[ALPHAConsoleModel alloc] initWithIdentifier:ALPHAConsoleDataIdentifier];
    model.logs = [self systemLogs];
    
    return model;
}

@end
