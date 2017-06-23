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

#import "SpeakerInfoDataDisplayManager.h"
#import "SpeakerInfoCellObjectBuilder.h"
#import "SpeakerInfoSectionHeaderCellObject.h"
#import "SpeakerInfoTableViewCellObject.h"
#import "SpeakerInfoSocialContactsCellObject.h"
#import "SpeakerInfoSocialContactsTableViewCell.h"
#import "SpeakerInfoSectionHeaderTableViewCell.h"
#import "SpeakerInfoTableViewCell.h"

@interface SpeakerInfoDataDisplayManagerTests : XCTestCase

@property (nonatomic, strong) SpeakerInfoDataDisplayManager *dataDisplayManager;
@property (nonatomic, strong) id mockCellObjectsBuilder;

@end

@implementation SpeakerInfoDataDisplayManagerTests

- (void)setUp {
    [super setUp];
    self.dataDisplayManager = [SpeakerInfoDataDisplayManager new];
    
    self.mockCellObjectsBuilder = OCMClassMock([SpeakerInfoCellObjectBuilder class]);
    
    self.dataDisplayManager.cellObjectBuilder = self.mockCellObjectsBuilder;
}

- (void)tearDown {
    self.dataDisplayManager = nil;
    
    [self.mockCellObjectsBuilder stopMocking];
    self.mockCellObjectsBuilder = nil;
    
    [super tearDown];
}

- (void)testSuccessConfigureDataDisplayManagerWithEvent {
    // given
    id speaker = [NSObject new];
    id speakerInfo = [SpeakerInfoTableViewCellObject new];
    id sectionHeader = [SpeakerInfoSectionHeaderCellObject new];
    id socialNetwork = [SpeakerInfoSocialContactsCellObject new];
    UITableView *tableView = [UITableView new];
    
    NSArray *cellObjects = @[speakerInfo, sectionHeader, socialNetwork];
    NSArray *cellClasses = @[[SpeakerInfoTableViewCell class], [SpeakerInfoSectionHeaderTableViewCell class], [SpeakerInfoSocialContactsTableViewCell class]];
    
    OCMStub([self.mockCellObjectsBuilder buildObjectsWithSpeaker:speaker]).andReturn(cellObjects);
    
    // when
    [self.dataDisplayManager configureDataDisplayManagerWithSpeaker:speaker];
    id<UITableViewDataSource> dataSource = [self.dataDisplayManager dataSourceForTableView:tableView];
    tableView.dataSource = dataSource;

    // then
    for (NSInteger index = 0; index < 3; index++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
        UITableViewCell *cell = [dataSource tableView:tableView
                                cellForRowAtIndexPath:indexPath];
        Class class = cellClasses[index];
        XCTAssertEqual(class, cell.class);
    }
}

- (void)testThatDataDisplayManagerReturnsTableViewDataSource{
    // given
    
    // when
    id <UITableViewDataSource> dataSource = [self.dataDisplayManager dataSourceForTableView:nil];
    
    // then
    XCTAssertNotNil(dataSource);
}

@end
