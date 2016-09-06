//
//  TagCollectionViewCellTests.m
//  LiveJournal
//
//  Created by Golovko Mikhail on 28/12/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "TagCollectionViewCell.h"
#import "TagCollectionViewCellObject.h"

@interface TagCollectionViewCellTests : XCTestCase

@property (nonatomic, strong) TagCollectionViewCell *cell;
@property (nonatomic, strong) id mockLabel;

@end

@implementation TagCollectionViewCellTests

- (void)setUp {
    [super setUp];

    self.cell = [TagCollectionViewCell new];
    self.mockLabel = OCMClassMock([UILabel class]);

    self.cell.tagLabel = self.mockLabel;
}

- (void)tearDown {

    self.cell = nil;

    self.mockLabel = nil;

    [super tearDown];
}

- (void)testConfigureCell {
    // given
    NSString *tagName = @"tag 1";
    id cellObject = [[TagCollectionViewCellObject alloc] initWithTagName:tagName];

    // when
    [self.cell shouldUpdateCellWithObject:cellObject];

    // then
    OCMVerify([self.mockLabel setText:tagName]);
}

@end
