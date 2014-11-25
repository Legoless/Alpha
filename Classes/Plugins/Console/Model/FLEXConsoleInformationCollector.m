//
//  FLEXConsoleInformationCollector.m
//  UICatalog
//
//  Created by Dal Rupnik on 10/11/14.
//  Copyright (c) 2014 f. All rights reserved.
//

#import <asl.h>

#import "FLEXConsoleLog.h"

#import "FLEXConsoleInformationCollector.h"

@interface FLEXConsoleInformationCollector ()

@end

@implementation FLEXConsoleInformationCollector

- (NSArray *)logs
{
    return [self systemLogs];
}

- (NSArray *)systemLogs
{
    NSMutableArray* logs = [NSMutableArray array];
    
    //
    // http://www.cocoanetics.com/2011/03/accessing-the-ios-system-log/
    //
    aslmsg q, m;
    int i;
    const char *key, *val;
    
    q = asl_new(ASL_TYPE_QUERY);
    
    aslresponse r = asl_search(NULL, q);
    while (NULL != (m = aslresponse_next(r)))
    {
        NSMutableDictionary *tmpDict = [NSMutableDictionary dictionary];
        
        for (i = 0; (NULL != (key = asl_key(m, i))); i++)
        {
            NSString *keyString = [NSString stringWithUTF8String:(char *)key];
            
            val = asl_get(m, key);
            
            NSString *string = val?[NSString stringWithUTF8String:val]:@"";
            [tmpDict setObject:string forKey:keyString];
        }
        
        FLEXConsoleLog* log = [[FLEXConsoleLog alloc] initWithDictionary:tmpDict error:nil];
        
        if (log)
        {
            [logs addObject:log];
        }
    }
    aslresponse_free(r);
    
    return [logs copy];
}

- (void)activate
{
    //[self redirectConsoleOutput];
}

- (void)redirectConsoleOutput
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *logPath = [documentsDirectory stringByAppendingPathComponent:@"console.log"];
    freopen([logPath fileSystemRepresentation],"a+",stderr);

    //dup2(fileno(stdout), fileno(stderr));
}


@end
