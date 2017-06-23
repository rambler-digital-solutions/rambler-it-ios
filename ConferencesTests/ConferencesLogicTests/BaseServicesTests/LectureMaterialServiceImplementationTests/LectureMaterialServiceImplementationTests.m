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
#import "LectureMaterialServiceImplementation.h"
#import "LectureMaterialDownloadingManager.h"
#import "LectureMaterialConstants.h"
#import "LectureMaterialModelObject.h"
#import "LectureMaterialDownloadingDelegate.h"

@interface LectureMaterialServiceImplementationTests : XCTestCase

@property (nonatomic, strong) LectureMaterialServiceImplementation *service;
@property (nonatomic, strong) id mockFileManager;
@property (nonatomic, strong) id mockLectureMaterialDownloadManager;
@property (nonatomic, strong) id mockHandler;
@property (nonatomic, strong) id<LectureMaterialDownloadingDelegate> mockDownloadingDelegate;

@end

@implementation LectureMaterialServiceImplementationTests

- (void)setUp {
    [super setUp];
    
    [MagicalRecord setupCoreDataStackWithInMemoryStore];
    self.mockFileManager = [NSFileManager defaultManager];
    self.mockLectureMaterialDownloadManager = OCMClassMock([LectureMaterialDownloadingManager class]);
    self.mockHandler = OCMProtocolMock(@protocol(LectureMaterialHandler));
    
    self.service = [[LectureMaterialServiceImplementation alloc] initWithLectureMaterialHandlers:@[self.mockHandler]];
    self.service.fileManager = self.mockFileManager;
    self.service.lectureMaterialDownloadManager = self.mockLectureMaterialDownloadManager;
}

- (void)tearDown {
    self.service = nil;
    
    self.mockFileManager = nil;
    self.mockHandler = nil;
    
    [self.mockLectureMaterialDownloadManager stopMocking];
    self.mockLectureMaterialDownloadManager = nil;
    
    [MagicalRecord cleanUp];
    
    [super tearDown];
}

- (void)testThatServiceCreateCachedDirectoryCorrectly {
    // given
    NSString *cachedPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    cachedPath = [cachedPath stringByAppendingPathComponent:RITRelativePath];
    
    // when
    [self.service createCachedDirectoryIfNeeded];
    
    // then
    XCTAssertTrue([self.mockFileManager fileExistsAtPath:cachedPath]);
}

- (void)testThatServiceUpdateDelegateCorrectly {
    NSString *identifier = @"id";
    NSString *link = @"link";
    
    [self createLectureMaterialModelObjectWithId:identifier
                                            link:link
                                        localURL:nil];
    // when
    [self.service updateDelegate:self.mockDownloadingDelegate
            forLectureMaterialId:identifier];
    
    // then
    OCMVerify([self.mockLectureMaterialDownloadManager updateDelegate:self.mockDownloadingDelegate
                                                               forURL:link]);
}

- (void)testThatServiceDownloadMaterialCorrectly {
    // given
    NSString *identifier = @"id";
    NSString *link = @"link";
    NSString *localURL = @"local";
    LectureMaterialModelObject * material = [self createLectureMaterialModelObjectWithId:identifier
                                                                                    link:link
                                                                                localURL:localURL];
    OCMStub([self.mockHandler canHandleLectureMaterial:OCMOCK_ANY]).andReturn(YES);
    [self stubHandlerDownloadMaterialMethodWithLocalURL:localURL
                                                  error:nil];
    // when
    [self.service downloadToCacheLectureMaterialId:identifier
                                          delegate:self.mockDownloadingDelegate];
    
    // then
    material = [LectureMaterialModelObject MR_findFirst];
    OCMVerify([self.mockLectureMaterialDownloadManager registerDelegate:self.mockDownloadingDelegate
                                                                 forURL:link]);
    XCTAssertEqualObjects(material.localURL, localURL);
}

- (void)testThatServiceDownloadMaterialWithError {
    // given
    NSString *identifier = @"id";
    NSString *link = @"link";
    NSError *error = [NSError new];
    LectureMaterialModelObject * material = [self createLectureMaterialModelObjectWithId:identifier
                                                                                    link:link
                                                                                localURL:nil];
    OCMStub([self.mockHandler canHandleLectureMaterial:OCMOCK_ANY]).andReturn(YES);
    
    // when
    [self.service downloadToCacheLectureMaterialId:identifier
                                          delegate:self.mockDownloadingDelegate];
    
    // then
    material = [LectureMaterialModelObject MR_findFirst];
    OCMVerify([self.mockLectureMaterialDownloadManager registerDelegate:self.mockDownloadingDelegate
                                                                 forURL:link]);
    OCMVerify([self.mockDownloadingDelegate didEndDownloadingLectureMaterialWithLink:link
                                                                               error:error]);
}

- (void)testThatServiceRemoveMaterialCorrectly {
    // given
    NSString *identifier = @"id";
    NSString *link = @"link";
    NSString *localURL = @"local";
    LectureMaterialModelObject * material = [self createLectureMaterialModelObjectWithId:identifier
                                                                                    link:link
                                                                                localURL:localURL];
    OCMStub([self.mockHandler canHandleLectureMaterial:OCMOCK_ANY]).andReturn(YES);
    OCMStub([self.mockHandler removeFromCacheLectureMaterial:OCMOCK_ANY
                                                  completion:[OCMArg any]]).andDo(^(NSInvocation *invocation) {
        void (^passedBlock)(NSString *local, NSError *error);
        [invocation getArgument: &passedBlock atIndex: 3];
        passedBlock(nil, nil);
    });
    
    // when
    [self.service removeFromCacheLectureMaterialId:identifier
                                        completion:nil];
    
    // then
    material = [LectureMaterialModelObject MR_findFirst];
    XCTAssertEqualObjects(material.localURL, nil);
}

#pragma mark - private methods

- (LectureMaterialModelObject *)createLectureMaterialModelObjectWithId:(NSString *)identifier
                                                                  link:(NSString *)link
                                                              localURL:(NSString *)localURL {
    NSManagedObjectContext *rootSavingContext = [NSManagedObjectContext MR_rootSavingContext];
    __block LectureMaterialModelObject *material = nil;
    [rootSavingContext performBlockAndWait:^{
        material = [LectureMaterialModelObject MR_createEntityInContext:rootSavingContext];
        material.lectureMaterialId = identifier;
        material.link = link;
        material.localURL = localURL;
        [rootSavingContext MR_saveToPersistentStoreAndWait];
    }];
    return material;
}

- (void)stubHandlerDownloadMaterialMethodWithLocalURL:(NSString *)local
                                                error:(NSError *)error {
    OCMStub([self.mockHandler downloadToCacheLectureMaterial:OCMOCK_ANY
                                                    delegate:self.mockLectureMaterialDownloadManager
                                                  completion:[OCMArg any]]).andDo(^(NSInvocation *invocation) {
        void (^passedBlock)(NSString *local, NSError *error);
        [invocation getArgument: &passedBlock atIndex: 4];
        passedBlock(local, error);
    });
}
@end
