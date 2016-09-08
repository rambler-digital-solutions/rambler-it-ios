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
                                             return  obj.numberOfShowLine == expectedNumberOfLines
                                                     && [obj.objectDescriptor isEqual:objectDescriptor];
                                         }]
                                                    moduleOutput:nil]);

    // when
    [self.mediator configureWithObjectDescriptor:objectDescriptor
                                  tagModuleInput:self.mockTagInput];

    // then
    OCMVerifyAll(self.mockTagInput);
}

- (void)testObtainHeightWithObjectDescriptor {
    // given
    NSInteger expectedNumberOfLines = 3;
    TagObjectDescriptor *objectDescriptor = [[TagObjectDescriptor alloc] init];
    
    OCMExpect([self.mockTagInput obtainHeightTagModuleViewWithModuleConfig:
               [OCMArg checkWithBlock:^BOOL(TagModuleConfig *obj) {
        return obj.numberOfShowLine == expectedNumberOfLines
        && [obj.objectDescriptor isEqual:objectDescriptor];
    }]]);
    
    // when
    [self.mediator obtainHeightTagModuleViewWithObjectDescriptor:objectDescriptor
                                  tagModuleInput:self.mockTagInput];
    
    // then
    OCMVerifyAll(self.mockTagInput);
}

@end
