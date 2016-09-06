//
//  TagModuleTableViewCellTests.m
//  LiveJournal
//
//  Created by Golovko Mikhail on 31/12/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "TagModuleTableViewCell.h"
#import "TagModuleTableViewCellObject.h"
#import "TagCollectionView.h"
#import "ContentSizeObserver.h"
#import "TagMediatorInput.h"
#import "TagObjectDescriptor.h"

@interface TagModuleTableViewCellTests : XCTestCase

@property(nonatomic, strong) TagModuleTableViewCell *cell;
@property(nonatomic, strong) TagObjectDescriptor *mockObjectDescriptor;
@property(nonatomic, strong) id mockTagCollectionView;
@property(nonatomic, strong) id mockCollectionViewLayout;
@property(nonatomic, strong) id mockSizeObserver;
@property(nonatomic, strong) id mockMediatorInput;

@end

@implementation TagModuleTableViewCellTests

- (void)setUp {
    [super setUp];

    self.cell = [[TagModuleTableViewCell alloc] init];

    self.mockMediatorInput = OCMProtocolMock(@protocol(TagMediatorInput));

    self.mockObjectDescriptor = [[TagObjectDescriptor alloc] init];

    self.mockTagCollectionView = OCMClassMock([TagCollectionView class]);
    
    self.mockSizeObserver = OCMClassMock([ContentSizeObserver class]);
    self.mockCollectionViewLayout = OCMClassMock([UICollectionViewLayout class]);


    self.cell.tagCollectionView = self.mockTagCollectionView;
    self.cell.sizeObserver = self.mockSizeObserver;
    OCMStub([self.mockTagCollectionView collectionViewLayout]).andReturn(self.mockCollectionViewLayout);
}

- (void)tearDown {
    self.cell = nil;

    [self.mockTagCollectionView stopMocking];
    self.mockTagCollectionView = nil;

    [self.mockSizeObserver stopMocking];
    self.mockSizeObserver = nil;

    [self.mockMediatorInput stopMocking];
    self.mockMediatorInput = nil;
    
    [self.mockCollectionViewLayout stopMocking];
    self.mockCollectionViewLayout = nil;

    [super tearDown];
}

- (void)testShouldUpdateCellWithObject {
    // given
    id cellObject = [[TagModuleTableViewCellObject alloc] initWithObjectDescriptor:self.mockObjectDescriptor
                                                                     mediatorInput:self.mockMediatorInput];


    // when
    [self.cell shouldUpdateCellWithObject:cellObject];

    // then
    OCMVerify([self.mockSizeObserver setObserverView:self.mockTagCollectionView]);
    OCMVerify([self.mockMediatorInput configureWithObjectDescriptor:self.mockObjectDescriptor
                                                     tagModuleInput:self.mockTagCollectionView]);
}

- (void)testHeightForObject {
    // given
    TagModuleTableViewCellObject *cellObject = [[TagModuleTableViewCellObject alloc] init];
    cellObject.height = 44;

    // when
    CGFloat height = [TagModuleTableViewCell heightForObject:cellObject
                                                 atIndexPath:nil
                                                   tableView:nil];

    // then
    XCTAssertEqual(height, cellObject.height);
}

- (void)testContentSizeObserver {
    // given
    
    // when
    [self.cell contentSizeObserver:self.mockSizeObserver
          viewDidChangeContentSize:self.mockTagCollectionView];
    
    // then
    OCMVerify([self.mockCollectionViewLayout invalidateLayout]);
}

@end
