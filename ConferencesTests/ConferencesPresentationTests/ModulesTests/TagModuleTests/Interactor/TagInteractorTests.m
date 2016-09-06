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

#import "TagInteractor.h"
#import "TagService.h"
#import "TagModelObject.h"
#import "TagObjectDescriptor.h"

@interface TagInteractorTests : XCTestCase

@property(strong, nonatomic) TagInteractor *interactor;
@property(strong, nonatomic) id mockTagService;

@end

@implementation TagInteractorTests

#pragma mark - Настройка окружения для тестирования

- (void)setUp {
    [super setUp];

    self.interactor = [[TagInteractor alloc] init];
    self.mockTagService = OCMProtocolMock(@protocol(TagService));

    self.interactor.tagService = self.mockTagService;
}

- (void)tearDown {
    self.interactor = nil;

    self.mockTagService = nil;

    [super tearDown];
}

#pragma mark - Тестирование методов TagInteractorInput

- (void)testThatInteractorObtainTags {
    // given
    id objectDescriptor = [TagObjectDescriptor new];
    id excludeObjectDescriptor = [TagObjectDescriptor new];
    NSInteger kCountTag = 5;
    NSArray *tags = [self generateTags:kCountTag];
    NSArray *expectedResult = [self generateTagNames:tags];

    OCMStub([self.mockTagService obtainTagsFromObjectDescriptor:objectDescriptor
                                        excludeObjectDescriptor:excludeObjectDescriptor]).andReturn(tags);

    // when
    id result = [self.interactor obtainTagsFromObjectDescriptor:objectDescriptor
                                        excludeObjectDescriptor:excludeObjectDescriptor];
    // then
    XCTAssertEqualObjects(result, expectedResult);
}

- (void)testThatInteractorAddTag {
    // given
    id objectDescriptor = [TagObjectDescriptor new];
    id tagName = [NSString new];

    // when
    [self.mockTagService addTagWithName:tagName
                    forObjectDescriptor:objectDescriptor];

    // then
    OCMVerify([self.mockTagService addTagWithName:tagName
                              forObjectDescriptor:objectDescriptor]);
}

- (void)testThatInteractorRemoveTag {
    // given
    id objectDescriptor = [TagObjectDescriptor new];
    id tagName = [NSString new];

    // when
    [self.mockTagService removeTagWithName:tagName
                       forObjectDescriptor:objectDescriptor];

    // then
    OCMVerify([self.mockTagService removeTagWithName:tagName
                                 forObjectDescriptor:objectDescriptor]);
}

#pragma mark - Дополнительные методы

- (NSArray *)generateTags:(NSInteger)count {
    NSMutableArray *items = [NSMutableArray array];
    for (int i = 0; i < count; ++i) {
        TagModelObject *tag = OCMClassMock([TagModelObject class]);
        NSString *name = [NSString stringWithFormat:@"name %d", i];
        OCMStub([tag name]).andReturn(name);
        [items addObject:tag];
    }
    return [items copy];
}

- (NSArray *)generateTagNames:(NSArray *)tags {
    NSMutableArray *items = [NSMutableArray array];
    for (TagModelObject *tag in tags) {
        [items addObject:tag.name];
    }
    return [items copy];
}

@end