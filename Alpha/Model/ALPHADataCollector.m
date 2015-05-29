//
//  ALPHADataCollector.m
//  Alpha
//
//  Created by Dal Rupnik on 05/11/14.
//  Copyright (c) 2014 Unified Sense. All rights reserved.
//

#import "ALPHADataCollector.h"

@interface ALPHADataCollector ()

@property (nonatomic, strong) NSMutableOrderedSet *identifiers;

@end

@implementation ALPHADataCollector

- (NSMutableOrderedSet *)identifiers
{
    if (_identifiers)
    {
        _identifiers = [NSMutableOrderedSet orderedSet];
    }
    
    return _identifiers;
}

- (void)addDataIdentifier:(NSString *)identifier
{
    [self.identifiers addObject:identifier];
}

- (BOOL)hasDataForIdentifier:(NSString *)identifier
{
    return [self.identifiers containsObject:identifier];
}

- (void)collectDataForIdentifier:(NSString *)identifier completion:(void (^)(ALPHADataModel *, NSError *))completion
{
    
}

@end
