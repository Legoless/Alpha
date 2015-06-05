//
//  ALPHABaseSource.h
//  UICatalog
//
//  Created by Dal Rupnik on 29/05/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "ALPHADataSource.h"
#import "ALPHAIdentifiableItem.h"

@interface ALPHABaseSource : NSObject <ALPHADataSource>

- (void)refreshWithIdentifier:(NSString *)identifier completion:(ALPHADataSourceCompletion)completion;
- (void)refreshWithIdentifiers:(NSArray *)identifiers completion:(ALPHADataSourceCompletion)completion;

- (void)performAction:(id<ALPHAIdentifiableItem>)action completion:(ALPHADataSourceCompletion)completion;

@end
