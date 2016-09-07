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
#import "TagModuleTableViewCell.h"
#import "TagModuleTableViewCellObject.h"
#import "TagCollectionView.h"
#import "TagMediatorInput.h"
#import "TagObjectDescriptor.h"

static const CGFloat kDefaultMargin = 8.0f;

@interface TagModuleTableViewCellTests : XCTestCase

@property(nonatomic, strong) TagModuleTableViewCell *cell;
@property(nonatomic, strong) TagObjectDescriptor *mockObjectDescriptor;
@property(nonatomic, strong) id mockTagCollectionView;
@property(nonatomic, strong) id mockCollectionViewLayout;
@property(nonatomic, strong) id mockMediatorInput;

@end

@implementation TagModuleTableViewCellTests

- (void)setUp {
    [super setUp];

    self.cell = [[TagModuleTableViewCell alloc] init];

    self.mockMediatorInput = OCMProtocolMock(@protocol(TagMediatorInput));

    self.mockObjectDescriptor = [[TagObjectDescriptor alloc] init];

    self.mockTagCollectionView = OCMClassMock([TagCollectionView class]);
    
    self.mockCollectionViewLayout = OCMClassMock([UICollectionViewLayout class]);


    self.cell.tagCollectionView = self.mockTagCollectionView;
    OCMStub([self.mockTagCollectionView collectionViewLayout]).andReturn(self.mockCollectionViewLayout);
}

- (void)tearDown {
    self.cell = nil;

    [self.mockTagCollectionView stopMocking];
    self.mockTagCollectionView = nil;

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
    OCMVerify([self.mockMediatorInput configureWithObjectDescriptor:self.mockObjectDescriptor
                                                     tagModuleInput:self.mockTagCollectionView]);
}

- (void)testShouldUpdateCellWithObjectCorrectHeight {
    // given
    CGFloat heightTagView = 20.0f;
    CGFloat expectedCellHeight = heightTagView + 2 * kDefaultMargin ;
    TagModuleTableViewCellObject *cellObject = [[TagModuleTableViewCellObject alloc] initWithObjectDescriptor:self.mockObjectDescriptor
                                                                     mediatorInput:self.mockMediatorInput];
    OCMStub([self.mockMediatorInput obtainHeightTagModuleViewWithObjectDescriptor:self.mockObjectDescriptor
                                                                   tagModuleInput:self.mockTagCollectionView]).andReturn(heightTagView);
    
    
    // when
    [self.cell shouldUpdateCellWithObject:cellObject];
    
    // then
    XCTAssertEqual(cellObject.height, expectedCellHeight);
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

@end
