//
//  ALPHALibrarySource.m
//  Alpha
//
//  Created by Dal Rupnik on 09/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

@import ObjectiveC.runtime;

#import "ALPHARuntimeUtility.h"

#import "ALPHALibrarySource.h"
#import "ALPHAClassSource.h"

#import "ALPHATableScreenModel.h"

NSString* const ALPHALibraryDataIdentifier = @"com.unifiedsense.alpha.data.library";

@interface ALPHALibrarySource ()

@property (nonatomic, copy) NSArray *imageNames;

@end

@implementation ALPHALibrarySource

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        [self addDataIdentifier:ALPHALibraryDataIdentifier];
    }
    
    return self;
}

#pragma mark - ALPHADataCollector

- (ALPHAModel *)modelForRequest:(ALPHARequest *)request
{
    NSMutableArray *items = [NSMutableArray array];
    
    [self loadImageNames];
    
    for (NSString* fullImageName in self.imageNames)
    {
        ALPHAScreenItem *item = [[ALPHAScreenItem alloc] init];
        
        item.title = [self shortNameForImageName:fullImageName];
        item.object = [ALPHARequest requestWithIdentifier:ALPHAClassDataIdentifier parameters:@{ ALPHAClassBinaryParameterKey : fullImageName }];
        
        [items addObject:item];
    }
    
    //
    // Section & Model
    //
    
    ALPHAScreenSection* section = [[ALPHAScreenSection alloc] initWithIdentifier:ALPHALibraryDataIdentifier];
    section.items = items.copy;
    
    ALPHATableScreenModel* model = [[ALPHATableScreenModel alloc] initWithIdentifier:ALPHALibraryDataIdentifier];
    model.title = @"System Libraries";
    
    model.sections = @[ section ];
    
    return model;
}

#pragma mark - Binary Images

- (void)loadImageNames
{
    unsigned int imageNamesCount = 0;
    const char **imageNames = objc_copyImageNames(&imageNamesCount);
    
    if (imageNames)
    {
        NSMutableArray *imageNameStrings = [NSMutableArray array];
        NSString *appImageName = [ALPHARuntimeUtility applicationImageName];
        for (unsigned int i = 0; i < imageNamesCount; i++) {
            const char *imageName = imageNames[i];
            NSString *imageNameString = [NSString stringWithUTF8String:imageName];
            // Skip the app's image. We're just showing system libraries and frameworks.
            if (![imageNameString isEqual:appImageName]) {
                [imageNameStrings addObject:imageNameString];
            }
        }
        
        // Sort alphabetically
        self.imageNames = [imageNameStrings sortedArrayWithOptions:0 usingComparator:^NSComparisonResult(NSString *name1, NSString *name2) {
            NSString *shortName1 = [self shortNameForImageName:name1];
            NSString *shortName2 = [self shortNameForImageName:name2];
            return [shortName1 caseInsensitiveCompare:shortName2];
        }];
        
        free(imageNames);
    }
}

- (NSString *)shortNameForImageName:(NSString *)imageName
{
    NSString *shortName = nil;
    NSArray *components = [imageName componentsSeparatedByString:@"/"];
    NSUInteger componentsCount = [components count];
    if (componentsCount >= 2) {
        shortName = [NSString stringWithFormat:@"%@/%@", components[componentsCount - 2], components[componentsCount - 1]];
    }
    return shortName;
}

@end
