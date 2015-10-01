//
//  ALPHAAsset.m
//  Alpha
//
//  Created by Dal Rupnik on 18/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHAAsset.h"

@implementation ALPHAAsset

- (instancetype)init
{
    [NSException raise:@"ALPHAAssetMissingIdentifier" format:@"Asset needs identifier"];
    
    return nil;
}

- (instancetype)initWithIdentifier:(NSString *)identifier
{
    self = [super init];
    
    if (self)
    {
        NSAssert(identifier.length > 0, @"Asset needs identifier of more than zero length");
        self.identifier = identifier;
    }
    
    return self;
}

- (UIImage *)imageWithColor:(UIColor *)color
{
    return [self imageWithColor:color size:self.drawingSize];
}

- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    if (self.drawingBlock && !CGSizeEqualToSize(size, CGSizeZero))
    {
        return [UIImage alpha_imageWithSize:size color:color drawingBlock:self.drawingBlock];
    }
    
    if (self.assetImage && !CGSizeEqualToSize(size, CGSizeZero))
    {
        UIImage *image = self.assetImage;
        
        //
        // Image must be resized
        //
        if (!CGSizeEqualToSize(image.size, size))
        {
            CGRect rect = { { 0.0, 0.0 }, size };
            UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].nativeScale);
            [image drawInRect:rect];
            UIImage *picture1 = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
            NSData *imageData = UIImagePNGRepresentation(picture1);
            image = [UIImage imageWithData:imageData];
        }
        
        return [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    }
    
    return nil;
}

@end
