// Copyright (c) 2015 RAMBLER&Co
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
#import <ViperMcFlurry/ViperMcFlurry.h>
#import "StubTestHelper.h"

#import "LectureRouter.h"
#import "SpeakerInfoModuleInput.h"
#import "SafariFactory.h"
#import "YouTubePlayerFactory.h"

@interface LectureRouterTests : XCTestCase

@property (nonatomic, strong) LectureRouter *router;
@property (nonatomic, strong) id transitionHandlerMock;
@property (nonatomic, strong) id mockSafariFactory;
@property (nonatomic, strong) id mockYouTubePlayerFactory;

@end

@implementation LectureRouterTests

- (void)setUp {
    [super setUp];
    
    self.router = [LectureRouter new];
    self.transitionHandlerMock = OCMClassMock([UIViewController class]);
    self.mockSafariFactory = OCMProtocolMock(@protocol(SafariFactory));
    self.mockYouTubePlayerFactory = OCMProtocolMock(@protocol(YouTubePlayerFactory));
    
    self.router.transitionHandler = self.transitionHandlerMock;
    self.router.safariFactory = self.mockSafariFactory;
    self.router.youTubePlayerFactory = self.mockYouTubePlayerFactory;
}

- (void)tearDown {
    self.router = nil;
    
    [self.transitionHandlerMock stopMocking];
    self.transitionHandlerMock = nil;
    
    self.mockSafariFactory = nil;
    self.mockYouTubePlayerFactory = nil;
    
    [super tearDown];
}

#pragma mark - LectureRouterInput

- (void)testSuccessOpenSpeakerInfoModuleWithEventObjectId {
    // given
    NSString *objectId = @"3k3523";
    
    id <SpeakerInfoModuleInput> moduleInputMock = OCMProtocolMock(@protocol(SpeakerInfoModuleInput));
    
    StubTestHelper *stubTestHelper = [StubTestHelper new];
    [stubTestHelper stubTransitionHandler:self.transitionHandlerMock withModuleInputMock:moduleInputMock];
    
    // when
    [self.router openSpeakerInfoModuleWithSpeakerObjectId:objectId];
    
    // then
    OCMVerify([moduleInputMock configureCurrentModuleWithSpeakerId:objectId]);
}

- (void)testSuccessOpenWebBrowser {
    // given
    NSURL *testUrl = [NSURL URLWithString:@"rambler.ru"];
    
    // when
    [self.router openWebBrowserModuleWithUrl:testUrl];
    
    // then
    OCMVerify([self.mockSafariFactory createSafariViewControllerWithUrl:testUrl]);
}

- (void)testSuccessOpenYouTubePlayer {
    // given
    NSString *testIdentifier = @"1234";
    
    // when
    [self.router openYouTubeVideoPlayerModuleWithIdentifier:testIdentifier];
    
    // then
    OCMVerify([self.mockYouTubePlayerFactory createYouTubePlayerControllerWithVideoIdentifier:testIdentifier]);
}

@end
