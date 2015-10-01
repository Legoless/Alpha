//
//  ALPHAIvarRendererViewController.h
//  Alpha
//
//  Created by Dal Rupnik on 12/6/15.
//  Copyright © 2014 Unified Sense. All rights reserved.
//

#import "ALPHAFieldRendererViewController.h"

#import "ALPHAObjectIvar.h"

@interface ALPHAIvarRendererViewController : ALPHAFieldRendererViewController

+ (BOOL)canEditIvar:(ALPHAObjectIvar *)ivar;

@end
