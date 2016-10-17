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
#import <MessageUI/MessageUI.h>
#import <OCMock/OCMock.h>

#import "MailComposeControllerFactoryImplementation.h"

static NSString *const kTestEmail = @"etolstoy@rambler.ru";

@interface MailComposeControllerFactoryImplementationTests : XCTestCase

@property (nonatomic, strong) MailComposeControllerFactoryImplementation *factory;

@end

@implementation MailComposeControllerFactoryImplementationTests

- (void)setUp {
    [super setUp];
    
    self.factory = [MailComposeControllerFactoryImplementation new];
}

- (void)tearDown {
    self.factory = nil;
    
    [super tearDown];
}

- (void)testThatFactoryReturnsNilIfComposerNotAvailable {
    // given
    [self stubComposerAvailability:NO];
    
    // when
    id result = [self.factory obtainMailComposeViewControllerForRecepientEmail:kTestEmail];
    
    // then
    XCTAssertNil(result);
}

- (void)testThatFactoryReturnsComposer {
    // given
    [self stubComposerAvailability:YES];
    
    // when
    id result = [self.factory obtainMailComposeViewControllerForRecepientEmail:kTestEmail];
    
    // then
    XCTAssertNotNil(result);
}

#pragma mark - Helper methods

- (void)stubComposerAvailability:(BOOL)availability {
    id composerMock = OCMClassMock([MFMailComposeViewController class]);
    OCMStub([composerMock canSendMail]).andReturn(availability);
}

@end
