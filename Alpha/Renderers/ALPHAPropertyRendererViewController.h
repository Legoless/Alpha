//
//  ALPHAPropertyRendererViewController.h
//  Alpha
//
//  Created by Dal Rupnik on 12/6/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHAFieldRendererViewController.h"
#import "ALPHAObjectProperty.h"

@interface ALPHAPropertyRendererViewController : ALPHAFieldRendererViewController

+ (BOOL)canEditProperty:(ALPHAObjectProperty *)property;

@end
