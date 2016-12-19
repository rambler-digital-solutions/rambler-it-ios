//
//  LectureMaterialDownloadingManagerTests.m
//  Conferences
//
//  Created by k.zinovyev on 19.12.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

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
