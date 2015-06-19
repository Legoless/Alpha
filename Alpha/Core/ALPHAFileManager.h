//
//  ALPHAFileManager.h
//  Alpha
//
//  Created by Dal Rupnik on 25/11/14.
//  Copyright (c) 2014 Unified Sense. All rights reserved.
//

@interface ALPHAFileManager : NSObject

@property (nonatomic, readonly) NSURL* documentsDirectory;

@property (nonatomic, strong) NSDateFormatter* fileDateFormatter;

+ (instancetype)sharedManager;

@end
