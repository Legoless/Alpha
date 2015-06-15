//
//  ALPHAPropertyEditorViewController.h
//  Alpha
//
//  Created by Dal Rupnik on 12/6/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "ALPHAFieldEditorViewController.h"
#import "ALPHAObjectProperty.h"

@interface ALPHAPropertyEditorViewController : ALPHAFieldEditorViewController

+ (BOOL)canEditProperty:(ALPHAObjectProperty *)property;

@end
