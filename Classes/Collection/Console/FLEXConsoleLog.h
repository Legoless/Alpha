//
//  FLEXConsoleLog.h
//  UICatalog
//
//  Created by Dal Rupnik on 11/11/14.
//  Copyright (c) 2014 f. All rights reserved.
//

#import "JSONModel.h"

@interface FLEXConsoleLog : JSONModel

@property (nonatomic, copy) NSNumber<Optional> *ASLMessageID;
@property (nonatomic, copy) NSString<Optional> *facility;
@property (nonatomic, copy) NSNumber<Optional> *GID;
@property (nonatomic, copy) NSString<Optional> *host;
@property (nonatomic) NSInteger level;
@property (nonatomic, copy) NSString<Optional> *message;
@property (nonatomic, copy) NSNumber<Optional> *PID;
@property (nonatomic, copy) NSNumber<Optional> *readUID;
@property (nonatomic, copy) NSString<Optional> *sender;
@property (nonatomic, copy) NSString<Optional> *senderMachUUID;
@property (nonatomic, copy) NSString<Optional> *localTime;
@property (nonatomic, copy) NSNumber<Optional> *time;
@property (nonatomic, copy) NSNumber<Optional>* timeNanoSec;
@property (nonatomic, copy) NSNumber<Optional>* thread;
@property (nonatomic, copy) NSNumber<Optional>* UID;

@end
