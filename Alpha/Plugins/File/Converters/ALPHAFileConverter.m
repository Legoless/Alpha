//
//  ALPHAFileConverter.m
//  Alpha
//
//  Created by Dal Rupnik on 10/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHAFileConverter.h"
#import "ALPHAFileModel.h"

#import "ALPHATableScreenModel.h"

@implementation ALPHAFileConverter

- (BOOL)canConvertObject:(ALPHAModel *)model
{
    return [model isKindOfClass:[ALPHAFileModel class]];
}

- (ALPHAScreenModel *)screenModelForObject:(ALPHAFileModel *)model
{
    ALPHATableScreenModel* screenModel = [[ALPHATableScreenModel alloc] initWithIdentifier:model.request.identifier];
    screenModel.title = [model.currentFile.path lastPathComponent];
    
    ALPHAScreenSection* section = [[ALPHAScreenSection alloc] init];
    section.headerText = [NSString stringWithFormat:@"%lu files (%@)", (unsigned long)[model.files count], [NSByteCountFormatter stringFromByteCount:model.currentFile.size.longLongValue countStyle:NSByteCountFormatterCountStyleFile]];
    
    NSMutableArray* items = [NSMutableArray array];
    
    for (ALPHAFileObject* file in model.files)
    {
        ALPHAScreenItem* item = [[ALPHAScreenItem alloc] init];
        
        //
        // If this is a directory, we ask our own file source for another file model, so we identify ourselves with directory
        // identifier. If this is a file, then we create file request and file is displayed on view controller that handles
        // the file.
        //
        
        if (file.contents)
        {
            item.object = [ALPHARequest requestWithIdentifier:model.request.identifier parameters:@{ ALPHAFileURLParameterKey : file.path }];
        }
        else
        {
            item.object = [ALPHARequest requestForFile:file.path];
        }
        
        if (file.previewImage)
        {
            item.icon = file.previewImage;
            item.object = file.previewImage;
        }
        
        item.title = [file.path lastPathComponent];
        item.detail = [self subtitleForFileObject:file];
        
        item.style = UITableViewCellStyleSubtitle;
        
        [items addObject:item];
    }
    
    section.items = items.copy;
    
    screenModel.sections = @[ section ];
    
    return screenModel;
}

- (NSString *)subtitleForFileObject:(ALPHAFileObject *)fileObject
{
    if (fileObject.contents)
    {
        return [NSString stringWithFormat:@"%lu file%@", (unsigned long)fileObject.contents.longLongValue, (fileObject.contents.integerValue == 1 ? @"" : @"s")];
    }
    else
    {
        return [NSString stringWithFormat:@"%@ - %@", [NSByteCountFormatter stringFromByteCount:fileObject.size.longLongValue countStyle:NSByteCountFormatterCountStyleFile], fileObject.modificationDate];
    }
}

@end
