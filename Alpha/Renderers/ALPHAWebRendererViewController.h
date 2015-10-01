//
//  ALPHAWebRendererViewController.h
//  Alpha
//
//  Created by Dal Rupnik on 11/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHADataRenderer.h"

@interface ALPHAWebRendererViewController : UIViewController <ALPHADataRenderer>

#pragma mark - ALPHADataRenderer

@property (nonatomic, weak) id <ALPHAViewControllerDelegate> delegate;

@property (nonatomic, strong) ALPHAScreenModel* screenModel;

@property (nonatomic, strong) id<ALPHASerializableItem> object;

@property (nonatomic, copy) ALPHARequest *request;

@property (nonatomic, strong) id<ALPHADataSource> source;

@property (nonatomic, strong) ALPHATheme *theme;

@end
