// Copyright (c) 2016 RAMBLER&Co
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

#import <Nimbus/NimbusModels.h>
#import "LectureDataDisplayManager.h"
#import "LecturePlainObject.h"
#import "EventPlainObject.h"
#import "TableViewCellWithTextLabelCellObject.h"
#import "LectureDescriptionTableViewCellObject.h"
#import "DateFormatter.h"
#import "TableViewCellWithTextLabelCellObject.h"
#import "VideoRecordTableViewCellObject.h"
#import "LocalizedStrings.h"

@interface LectureDataDisplayManager ()

@property (strong, nonatomic) NITableViewModel *tableViewModel;
@property (strong, nonatomic) NITableViewActions *tableViewActions;
@property (strong, nonatomic) LecturePlainObject *lecture;

@end

@implementation LectureDataDisplayManager

#pragma mark - Public methods

- (void)configureDataDisplayManagerWithLecture:(LecturePlainObject *)lecture {
    self.lecture = lecture;
}

#pragma mark - UITableViewDelegate methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [NICellFactory tableView:tableView heightForRowAtIndexPath:indexPath model:self.tableViewModel];
}

#pragma mark - DataDisplayManager methods

- (id<UITableViewDataSource>)dataSourceForTableView:(UITableView *)tableView {
    if (!self.tableViewModel) {
        [self updateTableViewModel];
    }
    return self.tableViewModel;
}

- (id<UITableViewDelegate>)delegateForTableView:(UITableView *)tableView withBaseDelegate:(id<UITableViewDelegate>)baseTableViewDelegate {
    if (!self.tableViewActions) {
        [self setupTableViewActions];
    }
    return [self.tableViewActions forwardingTo:self];
}

#pragma mark - Private methods

- (NSArray *)generateCellObjects {
    NSString * date = [self.dateFormatter obtainDateWithDayMonthTimeFormat:self.lecture.event.startDate];
    LectureDescriptionTableViewCellObject * lectureDescriptionCellObject = [LectureDescriptionTableViewCellObject objectWithLecture:self.lecture andDate:date];

    TableViewCellWithTextLabelCellObject *videoRecordTextLabelCellObject = [TableViewCellWithTextLabelCellObject objectWithText:NSLocalizedString(VideoRecordTableViewCellTitle, nil)];
    
    VideoRecordTableViewCellObject *videoRecorTableViewCellObject = [VideoRecordTableViewCellObject new];
    
    TableViewCellWithTextLabelCellObject *materialsTextLabelCellObject = [TableViewCellWithTextLabelCellObject objectWithText:NSLocalizedString(LectureMaterialsTableViewCellTitle, nil)];
    
    return @[lectureDescriptionCellObject, videoRecordTextLabelCellObject, videoRecorTableViewCellObject, materialsTextLabelCellObject];
}

- (void)updateTableViewModel {
    NSArray *cellObjects = [self generateCellObjects];
    
    self.tableViewModel = [[NITableViewModel alloc] initWithSectionedArray:cellObjects delegate:(id)[NICellFactory class]];
}

- (void)setupTableViewActions {
    self.tableViewActions = [[NITableViewActions alloc] initWithTarget:self];
}

@end
