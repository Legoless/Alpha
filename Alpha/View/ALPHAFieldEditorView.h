//
//  ALPHAFieldEditorView.h
//  Alpha
//
//  Created by Dal Rupnik on 15/6/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

@import UIKit;

@interface ALPHAFieldEditorView : UIView

@property (nonatomic, copy) UIColor *separatorColor;

@property (nonatomic, copy) NSString *targetDescription;
@property (nonatomic, copy) NSString *fieldDescription;

@property (nonatomic, strong) NSArray *argumentInputViews;

@end
