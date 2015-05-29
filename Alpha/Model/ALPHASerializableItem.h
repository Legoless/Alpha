//
//  ALPHALoadableItem.h
//  Alpha
//
//  Created by Dal Rupnik on 29/05/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

/*!
 *  All objects that implement this protocol can be serialized to a BLOB
 */
@protocol ALPHASerializableItem <NSObject>

@property (nonatomic, copy) NSString *identifier;

- (instancetype)initWithIdentifier:(NSString *)identifier;

@end
