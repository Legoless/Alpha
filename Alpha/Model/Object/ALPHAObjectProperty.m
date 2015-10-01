//
//  ALPHAObjectProperty.m
//  Alpha
//
//  Created by Dal Rupnik on 11/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHARuntimeUtility.h"

#import "ALPHAObjectProperty.h"

@implementation ALPHAObjectProperty

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        self.type = [ALPHAObjectType new];
    }
    
    return self;
}

- (NSString *)description
{
    return [ALPHARuntimeUtility appendName:self.name toType:self.type.name];
}

- (NSString *)prettyDescription
{
    NSDictionary *attributesDictionary = self.attributes;
    NSMutableArray *attributesStrings = [NSMutableArray array];
    
    // Atomicity
    if ([attributesDictionary objectForKey:ALPHAUtilityAttributeNonAtomic])
    {
        [attributesStrings addObject:@"nonatomic"];
    }
    else
    {
        [attributesStrings addObject:@"atomic"];
    }
    
    // Storage
    if (self.attributes[ALPHAUtilityAttributeRetain])
    {
        [attributesStrings addObject:@"strong"];
    }
    else if (self.attributes[ALPHAUtilityAttributeCopy])
    {
        [attributesStrings addObject:@"copy"];
    }
    else if (self.attributes[ALPHAUtilityAttributeWeak])
    {
        [attributesStrings addObject:@"weak"];
    }
    else
    {
        [attributesStrings addObject:@"assign"];
    }
    
    // Mutability
    if (self.attributes[ALPHAUtilityAttributeReadOnly])
    {
        [attributesStrings addObject:@"readonly"];
    }
    else
    {
        [attributesStrings addObject:@"readwrite"];
    }
    
    // Custom getter/setter
    NSString *customGetter = self.attributes[ALPHAUtilityAttributeCustomGetter];
    NSString *customSetter = self.attributes[ALPHAUtilityAttributeCustomSetter];
    
    if (customGetter)
    {
        [attributesStrings addObject:[NSString stringWithFormat:@"getter=%@", customGetter]];
    }
    
    if (customSetter)
    {
        [attributesStrings addObject:[NSString stringWithFormat:@"setter=%@", customSetter]];
    }
    
    NSString *attributesString = [attributesStrings componentsJoinedByString:@", "];
    
    return [NSString stringWithFormat:@"@property (%@) %@ %@", attributesString, self.type.prettyDescription, self.name];
}

- (NSString *)setter
{
    NSString *setterSelectorString = self.attributes[ALPHAUtilityAttributeCustomSetter];
    
    if (!setterSelectorString)
    {
        NSString *propertyName = self.name;
        setterSelectorString = [NSString stringWithFormat:@"set%@%@:", [[propertyName substringToIndex:1] uppercaseString], [propertyName substringFromIndex:1]];
    }

    return setterSelectorString;
}

- (NSString *)getter
{
    NSString *getterSelectorString = self.attributes[ALPHAUtilityAttributeCustomGetter];
    
    if (!getterSelectorString)
    {
        getterSelectorString = self.name;
    }
    
    return getterSelectorString;
}

- (BOOL)isReadOnly
{
    return (self.attributes[ALPHAUtilityAttributeReadOnly] != nil);
}

- (BOOL)isDynamic
{
    return (self.attributes[ALPHAUtilityAttributeDynamic] != nil);
}

@end
