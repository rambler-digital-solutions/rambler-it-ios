//
//  TagInteractorTests.m
//  liveJournal
//
//  Created by Golovko Mikhail on 15/12/2015.
//  Copyright 2015 Rambler&Co. All rights reserved.
//

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