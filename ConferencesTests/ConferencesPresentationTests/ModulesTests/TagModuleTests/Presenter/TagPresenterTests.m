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

- (void)testThatPresenterObtainHeight {
    // given
    TagModuleConfig *moduleConfig = [TagModuleConfig new];
    NSArray *tags = [self generateTags];
    [self stubObtainTags:tags];
    
    // when
    [self.presenter obtainHeightTagModuleViewWithModuleConfig:moduleConfig];
    
    // then
    OCMVerify([self.mockView obtainHeightTagCollectionViewWithTags:tags]);
}

#pragma mark - Дополнительные методы

- (NSArray *)generateTags {
    return @[@"tag 1", @"tag 2"];
}

- (void)stubObtainTags:(NSArray *)tags {
    OCMStub([self.mockInteractor obtainTagsFromObjectDescriptor:OCMOCK_ANY]).andReturn(tags);
}

@end