//
//  SpotlightImageIndexerTests.m
//  Conferences
//
//  Created by k.zinovyev on 21.12.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import <SDWebImage/SDImageCache.h>
#import <SDWebImage/SDWebImageManager.h>
#import "SpotlightImageIndexer.h"
#import "SpeakerImageIndexer.h"
#import "SpotlightImageModel.h"

@interface SpotlightImageIndexerTests : XCTestCase

@property (nonatomic, strong) SpotlightImageIndexer *imageIndexer;
@property (nonatomic, strong) id mockEntityIndexer;
@property (nonatomic, strong) id mockCache;
@property (nonatomic, strong) id mockImageManager;

@end

@implementation SpotlightImageIndexerTests

- (void)setUp {
    [super setUp];

    self.mockEntityIndexer = OCMClassMock([SpeakerImageIndexer class]);
    self.mockCache = OCMClassMock([SDImageCache class]);
    self.mockImageManager = OCMClassMock([SDWebImageManager class]);
    
    self.imageIndexer = [[SpotlightImageIndexer alloc] init];
    self.imageIndexer.indexers = @[self.mockEntityIndexer];
    self.imageIndexer.imageCache = self.mockCache;
    self.imageIndexer.imageManager = self.mockImageManager;
}

- (void)tearDown {
    [self.mockEntityIndexer stopMocking];
    self.mockEntityIndexer = nil;
    
    [self.mockCache stopMocking];
    self.mockCache = nil;
    
    [self.mockImageManager stopMocking];
    self.mockImageManager = nil;
    
    self.imageIndexer = nil;
    
    [super tearDown];
}

- (void)testThatImageIndexerStartCorrectly {
    // given
    
    NSInteger options = SDWebImageLowPriority | SDWebImageContinueInBackground | SDWebImageRefreshCached;
    OCMStub([self.mockCache diskImageExistsWithKey:OCMOCK_ANY]).andReturn(NO);
    OCMStub([self.mockImageManager downloadImageWithURL:OCMOCK_ANY
                                      options:options
                                     progress:OCMOCK_ANY
                                    completed:([OCMArg invokeBlock])]);
    NSString *entityId = @"id";
    SpotlightImageModel *model = [[SpotlightImageModel alloc] initWithEntityId:@"id"
                                                                     imageLink:@"link"];
    OCMStub([self.mockEntityIndexer obtainImageModels]).andReturn(@[model]);
    
    // when
    [self.imageIndexer startIndexImageForSpotlight];
    
    // then
    OCMVerify([self.mockEntityIndexer updateModelsForEntityIdentifier:entityId]);
    
}

@end
