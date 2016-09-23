//
//  ALPHAConsoleLog.m
//  Alpha
//
//  Created by Dal Rupnik on 11/11/14.
//  Copyright © 2014 Unifed Sense. All rights reserved.
//

#import "ALPHAConsoleLog.h"
#import "ALPHASerialization.h" 

@implementation ALPHAConsoleLog

+ (BOOL)supportsSecureCoding {
    return YES;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    
    if (self)
    {
        self.level = [dictionary[@"Level"] integerValue];
        self.facility = dictionary[@"Facility"];
        self.host = dictionary[@"Host"];
        self.message = dictionary[@"Message"];
        self.readUID = dictionary[@"ReadUID"];
        self.sender = dictionary[@"Sender"];
        self.senderMachUUID = dictionary[@"SenderMachUUID"];
        self.time = dictionary[@"Time"];
        self.timeNanoSec = dictionary[@"TimeNanoSec"];
        self.thread = dictionary[@"CFLog Thread"];
        self.localTime = dictionary[@"CFLog Local Time"];
    }
    return self;
}

@end
