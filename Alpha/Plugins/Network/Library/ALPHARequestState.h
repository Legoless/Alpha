//
//  ALPHARequestState.h
//  Alpha
//
//  Created by Dal Rupnik on 08/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

@import Foundation;

/*!
 *  This object is used internally to track connections made out
 */
@interface ALPHARequestState : NSObject

@property (nonatomic, copy) NSURLRequest *request;
@property (nonatomic, copy) NSURLResponse *response;
@property (nonatomic, strong) NSMutableData *dataAccumulator;
@property (nonatomic, copy) NSString *requestID;

@end