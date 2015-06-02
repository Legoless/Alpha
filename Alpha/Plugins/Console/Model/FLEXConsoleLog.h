//
//  FLEXConsoleLog.h
//  UICatalog
//
//  Created by Dal Rupnik on 11/11/14.
//  Copyright (c) 2014 f. All rights reserved.
//

#import "ALPHASerializableItem.h"

@interface FLEXConsoleLog : NSObject <ALPHASerializableItem>

@property (nonatomic, copy) NSNumber *ASLMessageID;
@property (nonatomic, copy) NSString *facility;
@property (nonatomic, copy) NSNumber *GID;
@property (nonatomic, copy) NSString *host;
@property (nonatomic) NSInteger level;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSNumber *PID;
@property (nonatomic, copy) NSNumber *readUID;
@property (nonatomic, copy) NSString *sender;
@property (nonatomic, copy) NSString *senderMachUUID;
@property (nonatomic, copy) NSString *localTime;
@property (nonatomic, copy) NSNumber *time;
@property (nonatomic, copy) NSNumber *timeNanoSec;
@property (nonatomic, copy) NSNumber *thread;
@property (nonatomic, copy) NSNumber *UID;

@end
