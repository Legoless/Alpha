//
//  ALPHAIvarEditorViewController.h
//  Alpha
//
//  Created by Dal Rupnik on 12/6/15.
//  Copyright (c) 2014 Unified Sense. All rights reserved.
//

#import "ALPHAFieldEditorViewController.h"

#import "ALPHAObjectIvar.h"

@interface ALPHAIvarEditorViewController : ALPHAFieldEditorViewController

@property (nonatomic, strong) ALPHAObjectIvar *ivar;

+ (BOOL)canEditIvar:(ALPHAObjectIvar *)ivar;

@end
