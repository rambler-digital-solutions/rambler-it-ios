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

#import "ReportsSearchDataDisplayManager.h"


#import <Nimbus/NimbusModels.h>

#import "ReportEventTableViewCellObject.h"
#import "ReportLectureTableViewCellObject.h"
#import "ReportSpeakerTableViewCellObject.h"
#import "TableViewSectionHeaderCellObject.h"
#import "EventPlainObject.h"
#import "LecturePlainObject.h"
#import "SpeakerPlainObject.h"
#import "EXTScope.h"
#import "ReportsSearchCellObjectsDirector.h"

@interface ReportsSearchDataDisplayManager () <UITableViewDelegate>

@property (nonatomic, strong) NIMutableTableViewModel *tableViewModel;
@property (nonatomic, strong) NITableViewActions *tableViewActions;

@end

@implementation ReportsSearchDataDisplayManager

- (instancetype)initWithCellObjectDirector:(id<ReportsSearchCellObjectsDirector>)director {
    self = [super init];
    if (self) {
        _director = director;
    }
    return self;
}

- (void)updateTableViewModelWithObjects:(NSArray *)foundObjects searchText:(NSString *)searchText{
    [self updateTableViewModelWithObjects:foundObjects selectedText:searchText ];
    [self.delegate didUpdateTableViewModel];
}

#pragma mark - DataDisplayManager methods

- (id<UITableViewDataSource>)dataSourceForTableView:(UITableView *)tableView {
    if (!self.tableViewModel) {
        [self updateTableViewModelWithObjects:nil searchText:nil];
    }
    return self.tableViewModel;
}

- (id<UITableViewDelegate>)delegateForTableView:(UITableView *)tableView withBaseDelegate:(id<UITableViewDelegate>)baseTableViewDelegate {
    if (!self.tableViewActions) {
        [self setupTableViewActions];
    }
    return [self.tableViewActions forwardingTo:self];
}

#pragma mark - UITableViewDelegate methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [NICellFactory tableView:tableView heightForRowAtIndexPath:indexPath model:self.tableViewModel];
}

#pragma mark - Private methods

- (void)setupTableViewActions {
    self.tableViewActions = [[NITableViewActions alloc] initWithTarget:self];
    self.tableViewActions.tableViewCellSelectionStyle = UITableViewCellSelectionStyleNone;
    
    
    @weakify(self);
    NIActionBlock reportTapActionEventBlock = ^BOOL(ReportEventTableViewCellObject *object, id target, NSIndexPath *indexPath) {
        @strongify(self);
        [self.delegate didTapCellWithEvent:object.event];
        return YES;
    };
    NIActionBlock reportTapActionLectureBlock = ^BOOL(ReportLectureTableViewCellObject *object, id target, NSIndexPath *indexPath) {
        @strongify(self);
        [self.delegate didTapCellWithLecture:object.lecture];
        return YES;
    };
    NIActionBlock reportTapActionSpeakerBlock = ^BOOL(ReportSpeakerTableViewCellObject *object, id target, NSIndexPath *indexPath) {
        @strongify(self);
        [self.delegate didTapCellWithSpeaker:object.speaker];
        return YES;
    };
    
    [self.tableViewActions attachToClass:[ReportEventTableViewCellObject class] tapBlock:reportTapActionEventBlock];
    [self.tableViewActions attachToClass:[ReportLectureTableViewCellObject class] tapBlock:reportTapActionLectureBlock];
    [self.tableViewActions attachToClass:[ReportSpeakerTableViewCellObject class] tapBlock:reportTapActionSpeakerBlock];
}

- (void)updateTableViewModelWithObjects:(NSArray *)foundObjects selectedText:(NSString *)selectedText {
    NSArray *cellObjects = [self generateCellObjectsWithObjects:foundObjects selectedText:selectedText];
    
    self.tableViewModel = [[NIMutableTableViewModel alloc] initWithSectionedArray:cellObjects
                                                                         delegate:(id)[NICellFactory class]];
}

- (NSArray *)generateCellObjectsWithObjects:(NSArray *)foundObjects selectedText:(NSString *)selectedText {
    
    NSArray *cellObjects = [self.director generateCellObjectsFromPlainObjects:foundObjects selectedText:selectedText];
    
    return cellObjects;
}

@end
