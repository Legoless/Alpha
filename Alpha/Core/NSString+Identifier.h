//
//  NSString+Identifier.h
//  Alpha
//
//  Created by Dal Rupnik on 08/06/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

@interface NSString (Identifier)

- (NSString *)alpha_cleanCodeIdentifier;

- (NSString *)alpha_removeNamespacePrefix;

- (NSString *)alpha_titleCaseForCamelCase;

@end
