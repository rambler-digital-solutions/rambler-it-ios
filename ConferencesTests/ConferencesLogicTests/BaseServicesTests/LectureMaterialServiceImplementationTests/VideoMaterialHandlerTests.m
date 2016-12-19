//
//  VideoMaterialHandlerTests.m
//  Conferences
//
//  Created by k.zinovyev on 19.12.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import <MagicalRecord/MagicalRecord.h>
#import "VideoMaterialHandler.h"
#import "YouTubeIdentifierDeriviator.h"
#import "LectureMaterialModelObject.h"
#import "LectureMaterialType.h"

@interface VideoMaterialHandlerTests : XCTestCase

@property (nonatomic, strong) VideoMaterialHandler *handler;
@property (nonatomic, strong) id mockFileManager;
@property (nonatomic, strong) id mockDeriviator;

@end

@implementation VideoMaterialHandlerTests

- (void)setUp {
    [super setUp];
    [MagicalRecord setupCoreDataStackWithInMemoryStore];
    self.mockDeriviator = OCMClassMock([YouTubeIdentifierDeriviator class]);
    self.mockFileManager = OCMClassMock([NSFileManager class]);
    
    self.handler = [[VideoMaterialHandler alloc] init];
    self.handler.deriviator = self.mockDeriviator;
    self.handler.fileManager = self.mockFileManager;
}

- (void)tearDown {
    self.handler= nil;
    
    [self.mockDeriviator stopMocking];
    self.mockDeriviator = nil;
    
    [self.mockFileManager stopMocking];
    self.mockFileManager = nil;
    
    [MagicalRecord cleanUp];
    [super tearDown];
}

- (void)testThatHandlerCanHandleMaterialCorrectly {
    // given
    LectureMaterialModelObject *model = [self createLectureMaterial];
    
    NSURL *url = [NSURL URLWithString:model.link];
    OCMStub([self.mockDeriviator checkIfVideoIsFromYouTube:url]).andReturn(YES);
    
    // when
    BOOL couldHandle = [self.handler canHandleLectureMaterial:model];
    
    // then
    XCTAssertTrue(couldHandle);
}

- (void)testThatHandlerDownloadMaterialCorrectly {
    // given
    LectureMaterialModelObject *model = [self createLectureMaterial];
    NSString *identifier = @"identifier";
    NSURL *url = [NSURL URLWithString:model.link];
    OCMStub([self.mockDeriviator checkIfVideoIsFromYouTube:url]).andReturn(YES);
    OCMStub([self.mockDeriviator deriveIdentifierFromUrl:url]).andReturn(identifier);
    
    // when
    [self.handler downloadToCacheLectureMaterial:model
                                        delegate:nil
                                      completion:nil];
    
    // then
    OCMVerify([self.mockDeriviator checkIfVideoIsFromYouTube:url]);
    OCMVerify([self.mockDeriviator deriveIdentifierFromUrl:url]);
}

- (void)testThatHandlerRemoveMaterialCorrectly {
    // given
    LectureMaterialModelObject *model = [self createLectureMaterial];
    
    // when
    [self.handler removeFromCacheLectureMaterial:model
                                      completion:nil];
    // then
    OCMVerify([self.mockFileManager removeItemAtPath:model.localURL
                                               error:((NSError __autoreleasing **)[OCMArg anyPointer])]);
}

#pragma mark - Private methods

- (LectureMaterialModelObject *)createLectureMaterial {
    NSManagedObjectContext *rootSavingContext = [NSManagedObjectContext MR_rootSavingContext];
    __block LectureMaterialModelObject *material = nil;
    [rootSavingContext performBlockAndWait:^{
        material = [LectureMaterialModelObject MR_createEntityInContext:rootSavingContext];
        material.lectureMaterialId = @"identifier";
        material.link = @"link";
        material.type = LectureMaterialVideoType;
        [rootSavingContext MR_saveToPersistentStoreAndWait];
    }];
    return material;
};

@end
