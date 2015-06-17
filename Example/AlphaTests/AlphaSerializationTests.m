//
//  AlphaSerializationTests.m
//  Alpha
//
//  Created by Dal Rupnik on 17/06/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "ALPHASerialization.h"
#import "ALPHARequest.h"
#import "ALPHATestCase.h"

#import "ALPHADeviceStatusSource.h"
#import "ALPHATableScreenModel.h"

#import <XCTest/XCTest.h>

@interface AlphaSerializationTests : ALPHATestCase

@property (nonatomic, strong) id<ALPHASerializer> serializer;
@property (nonatomic, readonly) ALPHATableScreenModel* screenModel;

@end

@implementation AlphaSerializationTests

- (ALPHATableScreenModel *)screenModel
{
    return (ALPHATableScreenModel *)[[ALPHADeviceStatusSource new] modelForRequest:nil];
}

- (id<ALPHASerializer>)serializer
{
    if (!_serializer)
    {
        _serializer = [ALPHASerializerManager sharedManager];
    }
    
    return _serializer;
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

    id object = [self.serializer serializeObject:request];
    
    ALPHARequest* deserializedRequest = [self.serializer deserializeObject:object toClass:[ALPHARequest class]];
    
    XCTAssert([request.identifier isEqualToString:deserializedRequest.identifier], @"Equal identifiers");
    ALPHAAssertEqualDictionaries(request.parameters, deserializedRequest.parameters);
}

- (void)testTableScreenSerialization
{
    ALPHAModel* model = self.screenModel;

    id object = [self.serializer serializeObject:model];
    
    ALPHAModel* deserializedModel = [self.serializer deserializeObject:object toClass:[model class]];
    
    XCTAssert(model.class == deserializedModel.class, @"Equal superclass");
}

- (void)testTableScreenSectionSerialization
{
    ALPHATableScreenModel* model = self.screenModel;
    
    id object = [self.serializer serializeObject:model];
    
    ALPHATableScreenModel* deserializedModel = [self.serializer deserializeObject:object toClass:[model class]];
    
    //
    // Check all sections
    //
    
    for (NSUInteger i = 0; i < deserializedModel.sections.count; i++)
    {
        ALPHAScreenSection* deserializedSection = deserializedModel.sections[i];
        ALPHAScreenSection* originalSection = model.sections[i];
        
        XCTAssert([deserializedSection class] == [originalSection class], @"Section model class is are not equal");
        XCTAssert([deserializedSection.identifier isEqualToString:originalSection.identifier], @"Section identifiers are not equal");
        XCTAssert([deserializedSection.headerText isEqualToString:originalSection.headerText], @"Section header texts are not equal");
        XCTAssert([deserializedSection.footerText isEqualToString:originalSection.footerText], @"Section footer texts are not equal");
    }
}

- (void)testTableScreenSectionItemSerialization
{
    ALPHATableScreenModel* model = self.screenModel;
    
    id object = [self.serializer serializeObject:model];
    
    ALPHATableScreenModel* deserializedModel = [self.serializer deserializeObject:object toClass:[model class]];
    
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
            
            XCTAssert([deserializedItem class] == [originalItem class], @"Items must be of same class");
            XCTAssert([deserializedItem.objectClass isEqualToString:originalItem.objectClass], @"Items must have same object class");
            XCTAssert([deserializedItem.titleText isEqualToString:originalItem.titleText]);
            XCTAssert([deserializedItem.attributedTitleText isEqualToAttributedString:originalItem.attributedTitleText]);
            
            XCTAssert(deserializedItem.style == originalItem.style);
        }
        
        break;
    }
}

@end
