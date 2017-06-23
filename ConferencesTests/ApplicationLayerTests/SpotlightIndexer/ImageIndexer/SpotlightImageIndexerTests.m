// Copyright (c) 2016 RAMBLER&Co
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

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
