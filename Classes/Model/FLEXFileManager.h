//
//  FLEXFileManager.h
//  UICatalog
//
//  Created by Dal Rupnik on 25/11/14.
//  Copyright (c) 2014 f. All rights reserved.
//

@interface FLEXFileManager : NSObject

@property (nonatomic, readonly) NSURL* documentsDirectory;

@property (nonatomic, strong) NSDateFormatter* fileDateFormatter;

+ (instancetype)sharedManager;

@end
