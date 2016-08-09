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

#import "SpeakerInfoInteractor.h"
#import "ROSPonsomizer.h"
#import "SpeakerService.h"

@interface SpeakerInfoInteractorTests : XCTestCase

@property (nonatomic, strong) SpeakerInfoInteractor *interactor;
@property (nonatomic, strong) id mockSpeakerService;
@property (nonatomic, strong) id mockPonsomizer;

@end

@implementation SpeakerInfoInteractorTests

- (void)setUp {
    [super setUp];
    
    self.interactor = [SpeakerInfoInteractor new];
    self.mockPonsomizer = OCMProtocolMock(@protocol(ROSPonsomizer));
    self.mockSpeakerService = OCMProtocolMock(@protocol(SpeakerService));
    
    self.interactor.speakerService = self.mockSpeakerService;
    self.interactor.ponsomizer = self.mockPonsomizer;
}

- (void)tearDown {
    self.interactor = nil;
    
    self.mockPonsomizer = nil;
    self.mockSpeakerService = nil;
    
    [super tearDown];
}

#pragma mark - SpeakerInfoInteractorInput

- (void)testSuccessObtainSpeakerWithObjectId {
    // given
    NSString *speakerId = @"test id";
    id speaker = [NSObject new];
    id plainSpeaker = [NSObject new];
    
    OCMStub([self.mockSpeakerService obtainSpeakerWithSpeakerId:speakerId]).andReturn(speaker);
    OCMStub([self.mockPonsomizer convertObject:speaker]).andReturn(plainSpeaker);
    
    // when
    id result = [self.interactor obtainSpeakerWithSpeakerId:speakerId];
    
    // then
    XCTAssertEqualObjects(result, plainSpeaker);
}

@end
