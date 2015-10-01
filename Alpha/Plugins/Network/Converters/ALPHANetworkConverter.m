//
//  ALPHANetworkConverter.m
//  Alpha
//
//  Created by Dal Rupnik on 08/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHANetworkModel.h"
#import "ALPHANetworkConverter.h"
#import "ALPHATableScreenModel.h"
#import "ALPHAManager.h"

@implementation ALPHANetworkConverter

- (BOOL)canConvertObject:(ALPHAModel *)model
{
    return [model isKindOfClass:[ALPHANetworkModel class]];
}

- (ALPHAScreenModel *)screenModelForObject:(ALPHANetworkModel *)model
{
    ALPHATableScreenModel* screenModel = [[ALPHATableScreenModel alloc] initWithIdentifier:model.request.identifier];
    screenModel.title = @"Network";
    
    ALPHAScreenSection* section = [[ALPHAScreenSection alloc] init];
    
    NSMutableArray* items = [NSMutableArray array];
    
    for (ALPHANetworkConnection* connection in model.requests)
    {
        ALPHAScreenItem* item = [[ALPHAScreenItem alloc] init];
        item.object = [ALPHARequest requestForObject:connection];
        item.attributedTitleText = [self titleForConnection:connection];
        item.attributedDetailText = [self subtitleForConnection:connection];
        item.style = UITableViewCellStyleSubtitle;
        
        [items addObject:item];
    }
    
    section.items = items;
    
    screenModel.sections = @[ section ];
    
    return screenModel;
}

#pragma mark - Private methods

- (NSAttributedString *)titleForConnection:(ALPHANetworkConnection *)networkConnection
{
    NSString *method = networkConnection.request.method.uppercaseString;
    NSURL *url = [NSURL URLWithString:networkConnection.request.url];
    NSInteger statusCode = [networkConnection.response.status integerValue];
    
    NSString *string = [NSString stringWithFormat:@"● %@ %@", method, url.path];
    
    ALPHATheme* theme = [ALPHAManager defaultManager].theme;
    
    UIFont *font = theme.cellTitleFont;
    
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:string attributes:@{ NSFontAttributeName : font }];
    
    //
    // Get the color correct of status
    //
    
    if ( (statusCode >= 200) && (statusCode < 300) )
    {
        [title addAttributes:@{ NSForegroundColorAttributeName : [UIColor colorWithRed:39.0 / 255.0 green:174.0 / 255.0 blue:96.0 / 255.0 alpha:1.0] } range:NSMakeRange(0, 1)];
    }
    else
    {
        [title addAttributes:@{ NSForegroundColorAttributeName : [UIColor colorWithRed:231.0 / 255.0 green:76.0 / 255.0 blue:60.0 / 255.0 alpha:1.0] } range:NSMakeRange(0, 1)];
    }
    
    //
    // Bold the method
    //
    
    //[title addAttributes:@{ NSFontAttributeName : [UIFont boldSystemFontOfSize:font.pointSize] } range:NSMakeRange(2, method.length)];
    
    
    return title;
}


- (NSAttributedString *)subtitleForConnection:(ALPHANetworkConnection *)networkConnection
{
    NSURL *url = [NSURL URLWithString:networkConnection.request.url];
    
    NSTimeInterval time = fabs([networkConnection.timing.connectionEndDate timeIntervalSinceDate:networkConnection.timing.connectionStartDate]);
    double timeMilliseconds = time * 1000.0;
    
    NSMutableString *detailString = [NSMutableString stringWithString:@"   "];
    
    if (networkConnection.response.status.integerValue > 0)
    {
        [detailString appendFormat:@"%ld - ", networkConnection.response.status.longValue];
    }
    
    [detailString appendFormat:@"%@ - ", url.host];
    
    if (!networkConnection.timing.connectionEndDate)
    {
        [detailString appendString:@"Loading..."];
    }
    else
    {
        if (networkConnection.response.status.integerValue > 0)
        {
            [detailString appendFormat:@"%@ - ", [self shortStringForMimeType:networkConnection.response.mimeType]];
            
            NSString* bytes = [NSByteCountFormatter stringFromByteCount:networkConnection.size.longLongValue countStyle:NSByteCountFormatterCountStyleFile];
            
            [detailString appendFormat:@"%@ - ", bytes];
        }
        else if (networkConnection.error)
        {
            [detailString appendFormat:@"Error - "];
        }
        else
        {
            [detailString appendFormat:@"Timeout - "];
        }
        
        if (timeMilliseconds > 1000.0)
        {
            [detailString appendFormat:@"%.2f s", time];
        }
        else
        {
            [detailString appendFormat:@"%ld ms", (long)timeMilliseconds];
        }
    }
    
    ALPHATheme* theme = [ALPHAManager defaultManager].theme;
    
    UIFont *font = [theme.cellSubtitleFont fontWithSize:10.0];
    
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:detailString attributes:@{ NSFontAttributeName : font }];
    
    return title;
}

- (NSString *)shortStringForMimeType:(NSString *)mimeType
{
    NSString* finalType = [mimeType copy];
    
    if ([finalType hasPrefix:@"application"])
    {
        finalType = [finalType stringByReplacingOccurrencesOfString:@"application/" withString:@""];
    }
    
    return finalType;
}


@end
