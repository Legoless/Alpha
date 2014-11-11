//
//  FLEXConsoleInformationCollector.m
//  UICatalog
//
//  Created by Dal Rupnik on 10/11/14.
//  Copyright (c) 2014 f. All rights reserved.
//

#import "FLEXConsoleInformationCollector.h"

@interface FLEXConsoleInformationCollector ()

@end

@implementation FLEXConsoleInformationCollector

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
