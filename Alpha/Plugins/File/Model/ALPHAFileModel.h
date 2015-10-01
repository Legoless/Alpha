//
//  ALPHAFileModel.h
//  Alpha
//
//  Created by Dal Rupnik on 10/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHAModel.h"
#import "ALPHAFileObject.h"

@interface ALPHAFileModel : ALPHAModel

/*!
 *  Current file object
 */
@property (nonatomic, strong) ALPHAFileObject *currentFile;

/*!
 *  Current file is usually a directory, so this array contains file object instances of contents of the directory.
 */
@property (nonatomic, copy) NSArray *files;

@end
