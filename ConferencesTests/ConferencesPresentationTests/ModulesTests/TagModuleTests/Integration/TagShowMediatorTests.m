//
//  TagShowMediatorTests.m
//  LiveJournal
//
//  Created by Golovko Mikhail on 31/12/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "TagShowMediator.h"
#import "TagObjectDescriptor.h"
#import "TagModuleInput.h"
#import "TagModuleConfig.h"


@interface TagShowMediatorTests : XCTestCase

@property (nonatomic, strong) TagShowMediator *mediator;
@property (nonatomic, strong) id mockTagInput;

@end

@implementation TagShowMediatorTests

- (void)setUp {
    [super setUp];

    self.mediator = [[TagShowMediator alloc] init];

    self.mockTagInput = OCMProtocolMock(@protocol(TagModuleInput));
}

- (void)tearDown {

    self.mediator = nil;
    self.mockTagInput = nil;

    [super tearDown];
}

#pragma mark - Тестирование методоы TagMediatorInput

- (void)testСonfigureWithObjectDescriptor {
    // given
    NSInteger expectedNumberOfLines = 3;
    TagObjectDescriptor *objectDescriptor = [[TagObjectDescriptor alloc] init];

    OCMExpect([self.mockTagInput configureModuleWithModuleConfig:
                                         [OCMArg checkWithBlock:^BOOL(TagModuleConfig *obj) {
                                             return obj.verticalAlign
                                                     && !obj.enableAddButton
                                                     && !obj.enableRemoveButton
                                                     && obj.numberOfShowLine == expectedNumberOfLines
                                                     && [obj.objectDescriptor isEqual:objectDescriptor];
                                         }]
                                                    moduleOutput:nil]);

    // when
    [self.mediator configureWithObjectDescriptor:objectDescriptor
                                  tagModuleInput:self.mockTagInput];

    // then
    OCMVerifyAll(self.mockTagInput);
}

@end
