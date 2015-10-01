//
//  ALPHAConsoleConverter.m
//  Alpha
//
//  Created by Dal Rupnik on 03/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHAConsoleConverter.h"
#import "ALPHAConsoleModel.h"
#import "ALPHAConsoleLog.h"
#import "ALPHAManager.h"
#import "ALPHATableScreenModel.h"

@implementation ALPHAConsoleConverter

- (BOOL)canConvertObject:(ALPHAModel *)model
{
    return [model isKindOfClass:[ALPHAConsoleModel class]];
}

- (ALPHAScreenModel *)screenModelForObject:(ALPHAConsoleModel *)model
{
    ALPHATableScreenModel* screenModel = [[ALPHATableScreenModel alloc] initWithIdentifier:model.request.identifier];
    screenModel.title = @"Console";
    
    ALPHAScreenSection* section = [[ALPHAScreenSection alloc] init];
    
    NSMutableArray* items = [NSMutableArray array];
    
    for (ALPHAConsoleLog* log in model.logs)
    {
        ALPHAScreenItem* item = [[ALPHAScreenItem alloc] init];
        item.object = [ALPHARequest requestForObject:log];
        item.attributedTitleText = [self titleForLog:log];
        item.attributedDetailText = [self subtitleForLog:log];
        item.style = UITableViewCellStyleSubtitle;
        
        [items addObject:item];
    }
    
    section.items = items;
    
    screenModel.sections = @[ section ];
    
    return screenModel;
}

- (NSAttributedString *)titleForLog:(ALPHAConsoleLog *)consoleLog
{
    NSString *string = [NSString stringWithFormat:@"● %@", consoleLog.message];
    
    ALPHATheme* theme = [ALPHAManager defaultManager].theme;
    
    UIFont *font = theme.cellTitleFont;
    
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:string attributes:@{ NSFontAttributeName : font }];
    
    //
    // Get the color correct of status
    //
    
    if (consoleLog.level < 4)
    {
        [title addAttributes:@{ NSForegroundColorAttributeName : [UIColor colorWithRed:231.0 / 255.0 green:76.0 / 255.0 blue:60.0 / 255.0 alpha:1.0] } range:NSMakeRange(0, 2)];
        
    }
    else if (consoleLog.level < 6)
    {
        [title addAttributes:@{ NSForegroundColorAttributeName : [UIColor colorWithRed:241.0 / 255.0 green:196.0 / 255.0 blue:15.0 / 255.0 alpha:1.0] } range:NSMakeRange(0, 2)];
    }
    else
    {
        [title addAttributes:@{ NSForegroundColorAttributeName : [UIColor colorWithRed:52.0 / 255.0 green:152.0 / 255.0 blue:219.0 / 255.0 alpha:1.0] } range:NSMakeRange(0, 2)];
    }
    
    
    return title;
}

- (NSAttributedString *)subtitleForLog:(ALPHAConsoleLog *)consoleLog
{
    NSMutableString *detailString = [[NSMutableString alloc] init];
    
    [detailString appendFormat:@"  %@ %@[%@:%@]", consoleLog.localTime, consoleLog.sender, consoleLog.PID, consoleLog.ASLMessageID];
    
    ALPHATheme* theme = [ALPHAManager defaultManager].theme;
    
    UIFont *font = theme.cellSubtitleFont;
    
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:detailString attributes:@{ NSFontAttributeName : font }];
    
    return title;
}

@end
