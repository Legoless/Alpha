//
//  AlphaSerializationTests.m
//  Alpha
//
//  Created by Dal Rupnik on 17/06/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

@import XCTest;

#import "ALPHASerialization.h"
#import "ALPHARequest.h"
#import "ALPHATestCase.h"

#import "ALPHADeviceStatusSource.h"
#import "ALPHATableScreenModel.h"

@interface AlphaSerializationTests : ALPHATestCase

@property (nonatomic, readonly) ALPHATableScreenModel* screenModel;

@end

@implementation AlphaSerializationTests

- (ALPHATableScreenModel *)screenModel
{
    return (ALPHATableScreenModel *)[[ALPHADeviceStatusSource new] modelForRequest:nil];
}

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testRequest
{
    ALPHARequest* request = [ALPHARequest requestWithIdentifier:@"com.unifiedsense.test" parameters:@{ @"test" : @"parameter" }];

    id object = [NSKeyedArchiver archivedDataWithRootObject:request];
    
    ALPHARequest* deserializedRequest = [NSKeyedUnarchiver unarchiveObjectWithData:object];
    
    XCTAssert([request.identifier isEqualToString:deserializedRequest.identifier], @"Equal identifiers");
    ALPHAAssertEqualDictionaries(request.parameters, deserializedRequest.parameters);
}

- (void)testTableScreenSerialization
{
    ALPHAModel* model = self.screenModel;

    id object = [NSKeyedArchiver archivedDataWithRootObject:model];
    
    ALPHAModel* deserializedModel = [NSKeyedUnarchiver unarchiveObjectWithData:object];
    
    XCTAssert([NSStringFromClass(model.class) isEqualToString:NSStringFromClass(deserializedModel.class)], @"Equal superclass");
}

- (void)testTableScreenSectionSerialization
{
    ALPHATableScreenModel* model = self.screenModel;
    
    id object = [NSKeyedArchiver archivedDataWithRootObject:model];
    
    ALPHATableScreenModel* deserializedModel = [NSKeyedUnarchiver unarchiveObjectWithData:object];
    
    //
    // Check all sections
    //
    
    for (NSUInteger i = 0; i < deserializedModel.sections.count; i++)
    {
        ALPHAScreenSection* deserializedSection = deserializedModel.sections[i];
        ALPHAScreenSection* originalSection = model.sections[i];

        XCTAssert([NSStringFromClass(originalSection.class) isEqualToString:NSStringFromClass(deserializedSection.class)], @"Section model class are not equal");
        XCTAssert([deserializedSection.identifier isEqualToString:originalSection.identifier], @"Section identifiers are not equal");
        
        if (originalSection.headerText != nil)
        {
            XCTAssert([deserializedSection.headerText isEqualToString:originalSection.headerText], @"Section header texts are not equal");
        }
        
        if (originalSection.footerText != nil)
        {
            XCTAssert([deserializedSection.footerText isEqualToString:originalSection.footerText], @"Section footer texts are not equal");
        }
    }
}

- (void)testTableScreenSectionItemSerialization
{
    ALPHATableScreenModel* model = self.screenModel;
    
    id object = [NSKeyedArchiver archivedDataWithRootObject:model];
    
    ALPHATableScreenModel* deserializedModel = [NSKeyedUnarchiver unarchiveObjectWithData:object];
    
    //
    // Check all sections
    //
    
    for (NSUInteger i = 0; i < deserializedModel.sections.count; i++)
    {
        ALPHAScreenSection* deserializedSection = deserializedModel.sections[i];
        ALPHAScreenSection* originalSection = model.sections[i];

        for (NSUInteger x = 0; x < deserializedSection.items.count; x++)
        {
            ALPHAScreenItem* deserializedItem = deserializedSection.items[x];
            ALPHAScreenItem* originalItem = originalSection.items[x];
            
            XCTAssert([NSStringFromClass(originalItem.class) isEqualToString:NSStringFromClass(deserializedItem.class)], @"Items must be of same class");
            XCTAssert([deserializedItem.titleText isEqualToString:originalItem.titleText]);
            
            if (originalItem.attributedTitleText != nil)
            {
                XCTAssert([deserializedItem.attributedTitleText isEqualToAttributedString:originalItem.attributedTitleText]);
            }
            
            XCTAssert(deserializedItem.style == originalItem.style);
        }
        
        break;
    }
}

@end
