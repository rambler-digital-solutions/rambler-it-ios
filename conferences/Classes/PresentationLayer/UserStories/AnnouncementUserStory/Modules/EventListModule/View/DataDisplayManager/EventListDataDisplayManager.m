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

#import "EventListDataDisplayManager.h"

#import <Nimbus/NimbusModels.h>

#import "TableViewSectionHeaderCellObject.h"
#import "EventListTableViewCellObject.h"
#import "EventListCellObjectBuilder.h"
#import "EventPlainObject.h"
#import "DateFormatter.h"
#import "EXTScope.h"

@interface EventListDataDisplayManager () <UITableViewDelegate>

@property (strong, nonatomic) NIMutableTableViewModel *tableViewModel;
@property (strong, nonatomic) NITableViewActions *tableViewActions;

@end

@implementation EventListDataDisplayManager

- (void)updateTableViewModelWithEvents:(NSArray *)events {
    [self updateTableViewModel:events];
    [self.delegate didUpdateTableViewModel];
}

#pragma mark - DataDisplayManager methods

- (id<UITableViewDataSource>)dataSourceForTableView:(UITableView *)tableView {
    if (!self.tableViewModel) {
        self.tableViewModel = [[NIMutableTableViewModel alloc] initWithSectionedArray:@[@""]
                                                                             delegate:(id)[NICellFactory class]];
    }
    return self.tableViewModel;
}

- (id<UITableViewDelegate>)delegateForTableView:(UITableView *)tableView withBaseDelegate:(id<UITableViewDelegate>)baseTableViewDelegate {
    if (!self.tableViewActions) {
        [self setupTableViewActions];
    }
    return [self.tableViewActions forwardingTo:baseTableViewDelegate];
}

#pragma mark - Private methods

- (void)setupTableViewActions {
    self.tableViewActions = [[NITableViewActions alloc] initWithTarget:self];
    self.tableViewActions.tableViewCellSelectionStyle = UITableViewCellSelectionStyleNone;
    
    @weakify(self);
    NIActionBlock announcementListTapActionBlock = ^BOOL(EventListTableViewCellObject *object, id target, NSIndexPath *indexPath) {
        @strongify(self);
        [self.delegate didTapCellWithEvent:object.event];
        return YES;
    };
    
    [self.tableViewActions attachToClass:[EventListTableViewCellObject class]
                                tapBlock:announcementListTapActionBlock];
}

- (void)updateTableViewModel:(NSArray *)events {
    [self.tableViewModel removeSectionAtIndex:0];
    [self.tableViewModel addSectionWithTitle:@""];
    
    NSArray *cellObjects = [self.cellObjectBuilder buildCellObjectsWithEvents:events];
    [self.tableViewModel addObjectsFromArray:cellObjects];
}

@end
