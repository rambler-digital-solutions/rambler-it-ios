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

#import "ReportListDataDisplayManager.h"

#import <Nimbus/NimbusModels.h>

#import "ReportEventTableViewCellObject.h"
#import "TableViewSectionHeaderCellObject.h"
#import "DateFormatter.h"
#import "EventPlainObject.h"
#import "EXTScope.h"
#import "TagModelObject.h"
#import "LecturePlainObject.h"
#import "ReportListCellObjectFactory.h"

@interface ReportListDataDisplayManager () <UITableViewDelegate>

@property (strong, nonatomic) NITableViewModel *tableViewModel;
@property (strong, nonatomic) NITableViewActions *tableViewActions;
@property (strong, nonatomic) NSArray *events;

@end

@implementation ReportListDataDisplayManager

#pragma mark - DataDisplayManager methods

- (id<UITableViewDataSource>)dataSourceForTableView:(UITableView *)tableView
                                       withSuggests:(NSArray *)suggests {
    NSArray *cellObjects = [self.cellObjectFactory generateCellObjectsWithSuggests:suggests];
    self.tableViewModel = [[NITableViewModel alloc] initWithListArray:cellObjects
                                                             delegate:(id)[NICellFactory class]];
    return self.tableViewModel;
}

- (id<UITableViewDelegate>)delegateForTableView:(UITableView *)tableView
                               withBaseDelegate:(id<UITableViewDelegate>)baseTableViewDelegate {
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
    NIActionBlock reportTapActionBlock = ^BOOL(ReportEventTableViewCellObject *object, id target, NSIndexPath *indexPath) {
        @strongify(self);
        [self.delegate didTapCellWithEvent:object.event];
        return YES;
    };
    [self.tableViewActions attachToClass:[ReportEventTableViewCellObject class]
                                tapBlock:reportTapActionBlock];
}

@end
