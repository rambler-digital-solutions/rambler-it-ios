//
//  TagPresenterTests.m
//  liveJournal
//
//  Created by Golovko Mikhail on 15/12/2015.
//  Copyright 2015 Rambler&Co. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "TagPresenter.h"

#import "TagViewInput.h"
#import "TagInteractorInput.h"
#import "TagModuleOutput.h"
#import "TagModuleConfig.h"
#import "TagDataDisplayManager.h"
#import "TagObjectDescriptor.h"
#import "TagService.h"

@interface TagPresenterTests : XCTestCase

@property (strong, nonatomic) TagPresenter *presenter;

@property (strong, nonatomic) id mockInteractor;
@property (strong, nonatomic) id mockView;
@property (strong, nonatomic) id mockOutput;
@property (strong, nonatomic) id mockTagFilter;

@end

@implementation TagPresenterTests

#pragma mark - Настройка окружения для тестирования

- (void)setUp {
    [super setUp];

    self.presenter = [[TagPresenter alloc] init];

    self.mockInteractor = OCMProtocolMock(@protocol(TagInteractorInput));
    self.mockView = OCMProtocolMock(@protocol(TagViewInput));
    self.mockOutput = OCMProtocolMock(@protocol(TagModuleOutput));

    self.presenter.interactor = self.mockInteractor;
    self.presenter.view = self.mockView;
    self.presenter.output = self.mockOutput;
}

- (void)tearDown {
    self.presenter = nil;

    self.mockView = nil;
    self.mockInteractor = nil;
    self.mockOutput = nil;

    [self.mockTagFilter stopMocking];
    self.mockTagFilter = nil;

    [super tearDown];
}

#pragma mark - Тестирование методов TagModuleInput

- (void)testThatPresenterConfigureModule {
    // given
    id expectedOutput = [NSObject new];
    NSArray *tags = [self generateTags];
    [self stubObtainTags:tags];
    TagModuleConfig *moduleConfig = [TagModuleConfig new];
    moduleConfig.numberOfShowLine = 4;
    
    // when
    [self.presenter configureModuleWithModuleConfig:moduleConfig
                                       moduleOutput:expectedOutput];

    // then
    XCTAssertEqualObjects(self.presenter.output, expectedOutput);
    OCMVerify([self.mockView setupInitialState]);
    OCMVerify([self.mockView showTags:tags]);
    OCMVerify([self.mockView setupShowNumberOfLines:moduleConfig.numberOfShowLine]);
}

- (void)testThatPresenterConfigureHorizontalContentAlign {
    // given
    TagModuleConfig *moduleConfig = [TagModuleConfig new];
    moduleConfig.verticalAlign = NO;

    // when
    [self.presenter configureModuleWithModuleConfig:moduleConfig
                                       moduleOutput:nil];

    // then
    OCMVerify([self.mockView setupHorizontalContentAlign]);
}

- (void)testThatPresenterConfigureVerticalContentAlign {
    // given
    TagModuleConfig *moduleConfig = [TagModuleConfig new];
    moduleConfig.verticalAlign = YES;

    // when
    [self.presenter configureModuleWithModuleConfig:moduleConfig
                                       moduleOutput:nil];

    // then
    OCMVerify([self.mockView setupVerticalContentAlign]);
}

#pragma mark - Дополнительные методы

- (NSArray *)generateTags {
    return @[@"tag 1", @"tag 2"];
}

- (void)stubObtainTags:(NSArray *)tags {
    OCMStub([self.mockInteractor obtainTagsFromObjectDescriptor:OCMOCK_ANY
                                        excludeObjectDescriptor:OCMOCK_ANY]).andReturn(tags);
}

@end