//
//  ALPHAFileManager.h
//  Alpha
//
//  Created by Dal Rupnik on 25/11/14.
//  Copyright © 2014 Unified Sense. All rights reserved.
//

@import Foundation;

@interface ALPHAFileManager : NSObject

@property (nonatomic, readonly) NSURL* documentsDirectory;

@property (nonatomic, strong) NSDateFormatter* fileDateFormatter;

+ (instancetype)sharedManager;

@end
