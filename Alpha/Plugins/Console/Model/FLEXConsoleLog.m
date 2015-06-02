//
//  FLEXConsoleLog.m
//  UICatalog
//
//  Created by Dal Rupnik on 11/11/14.
//  Copyright (c) 2014 f. All rights reserved.
//

#import "FLEXConsoleLog.h"

@implementation FLEXConsoleLog

- (id)initWithDictionary:(NSDictionary *)dict error:(NSError *__autoreleasing *)err
{
    //
    // Fix dictionary keys
    //
    
    NSMutableDictionary *dictionary = [dict mutableCopy];
    dictionary[@"level"] = dictionary[@"Level"];
    dictionary[@"facility"] = dictionary[@"Facility"];
    dictionary[@"host"] = dictionary[@"Host"];
    dictionary[@"message"] = dictionary[@"Message"];
    dictionary[@"readUID"] = dictionary[@"ReadUID"];
    dictionary[@"sender"] = dictionary[@"Sender"];
    dictionary[@"senderMachUUID"] = dictionary[@"SenderMachUUID"];
    dictionary[@"time"] = dictionary[@"Time"];
    dictionary[@"timeNanoSec"] = dictionary[@"TimeNanoSec"];
    dictionary[@"thread"] = dictionary[@"CFLog Thread"];
    dictionary[@"localTime"] = dictionary[@"CFLog Local Time"];
    
    return [super init];
}

@end
