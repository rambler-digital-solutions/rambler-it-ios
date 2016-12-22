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
#import <MagicalRecord/MagicalRecord.h>
#import "LectureMaterialDownloadingManager_Testable.h"
#import "LectureMaterialDownloadingDelegate.h"

@interface LectureMaterialDownloadingManagerTests : XCTestCase

@property (nonatomic, strong) LectureMaterialDownloadingManager *manager;

@end

@implementation LectureMaterialDownloadingManagerTests

- (void)setUp {
    [super setUp];
    
    [MagicalRecord setupCoreDataStackWithInMemoryStore];
    self.manager = [[LectureMaterialDownloadingManager alloc] init];
}

- (void)tearDown {
    self.manager = nil;
    [MagicalRecord cleanUp];
    [super tearDown];
}

- (void)testThatManagerRegisterDelegateCorrecrtly {
    // given
    id delegate = OCMProtocolMock(@protocol(LectureMaterialDownloadingDelegate));
    NSString *url = @"url";
    // when
    [self.manager registerDelegate:delegate
                            forURL:url];
    
    // then
    id result = [self.manager.delegatesByIdentifier objectForKey:url];
    XCTAssertEqual(result, delegate);
    
}

- (void)testThatManagerUpdateDelegateIfExistCorrecrtly {
    // given
    id delegate = OCMProtocolMock(@protocol(LectureMaterialDownloadingDelegate));
    id newDelegate = OCMProtocolMock(@protocol(LectureMaterialDownloadingDelegate));
    NSString *url = @"url";
    [self.manager registerDelegate:delegate
                            forURL:url];
    // when
    [self.manager updateDelegate:newDelegate
                          forURL:url];
    
    // then
    id result = [self.manager.delegatesByIdentifier objectForKey:url];
    XCTAssertEqual(result, newDelegate);
}

- (void)testThatManagerUpdateDelegateIfNotExistCorrecrtly {
    // given
    id delegate = OCMProtocolMock(@protocol(LectureMaterialDownloadingDelegate));
    NSString *url = @"url";
    // when
    [self.manager updateDelegate:delegate
                          forURL:url];
    
    // then
    id result = [self.manager.delegatesByIdentifier objectForKey:url];
    XCTAssertNil(result);
}

- (void)testThatManagerDidFinishDownloadingCorrecrtly {
    // given
    id delegate = OCMProtocolMock(@protocol(LectureMaterialDownloadingDelegate));
    NSString *url = @"url";
    NSURL *path = [NSURL URLWithString:@"path"];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    session.sessionDescription = url;
    [self.manager registerDelegate:delegate
                            forURL:url];
    // when
    [self.manager URLSession:session
                downloadTask:OCMOCK_ANY
   didFinishDownloadingToURL:path];
    // then
    id result = [self.manager.delegatesByIdentifier objectForKey:url];
    XCTAssertNil(result);
    OCMVerify([delegate URLSession:session
                      downloadTask:OCMOCK_ANY
         didFinishDownloadingToURL:path]);
}

- (void)testThatManagerDidCompleteWithErrorCorrecrtly {
    // given
    id delegate = OCMProtocolMock(@protocol(LectureMaterialDownloadingDelegate));
    NSString *url = @"url";
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    session.sessionDescription = url;
    [self.manager registerDelegate:delegate
                            forURL:url];
    // when
    [self.manager URLSession:session
                        task:OCMOCK_ANY
        didCompleteWithError:OCMOCK_ANY];
    // then
    id result = [self.manager.delegatesByIdentifier objectForKey:url];
    XCTAssertNil(result);
    OCMVerify([delegate URLSession:session
                              task:OCMOCK_ANY
              didCompleteWithError:OCMOCK_ANY]);
}


@end
