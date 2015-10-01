//
//  ALPHAFileObject.h
//  Alpha
//
//  Created by Dal Rupnik on 10/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHASerialization.h"

@import UIKit;

@interface ALPHAFileObject : NSObject <ALPHASerializableItem>

/*!
 *  Path to file on drive
 */
@property (nonatomic, copy) NSString *path;

/*!
 *  Current path size
 */
@property (nonatomic, copy) NSNumber *size;

/*!
 *  If this property is set, file is a directory and includes number of files
 */
@property (nonatomic, copy) NSNumber *contents;

/*!
 *  File modification date
 */
@property (nonatomic, copy) NSDate *modificationDate;

/*!
 *  If obtainable, contains preview image
 */
@property (nonatomic, strong) UIImage *previewImage;

@end
