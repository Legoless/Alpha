//
//  UIDevice+Status.h
//  UICatalog
//
//  Created by Dal Rupnik on 20/05/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (Status)

- (float)alpha_gsmSignalStrength;

- (NSString *)alpha_serviceProvider;

@end
