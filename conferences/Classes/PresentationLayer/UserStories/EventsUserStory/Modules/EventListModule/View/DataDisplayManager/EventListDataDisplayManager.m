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

#import "EventListTableViewCellObject.h"
#import "NearestEventTableViewCellObject.h"
#import "EventPlainObject.h"
#import "DateFormatter.h"

@interface EventListDataDisplayManager () <UITableViewDelegate>

@property (strong, nonatomic) NIMutableTableViewModel *tableViewModel;
@property (strong, nonatomic) NITableViewActions *tableViewActions;
@property (strong, nonatomic) NSArray *events;

@end

@implementation EventListDataDisplayManager

- (void)updateTableViewModelWithEvents:(NSArray *)events {
    self.events = events;
    self.tableViewModel = [self updateTableViewModel];
    [self.delegate didUpdateTableViewModel];
}

#pragma mark - DataDisplayManager methods

- (id<UITableViewDataSource>)dataSourceForTableView:(UITableView *)tableView {
    if (!self.tableViewModel) {
        self.tableViewModel = [self updateTableViewModel];
    }
    return self.tableViewModel;
}

- (id<UITableViewDelegate>)delegateForTableView:(UITableView *)tableView withBaseDelegate:(id<UITableViewDelegate>)baseTableViewDelegate {
    if (!self.tableViewActions) {
        [self setupActionBlocks];
    }
    return [self.tableViewActions forwardingTo:self];
}

#pragma mark - UITableViewDelegate methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [NICellFactory tableView:tableView heightForRowAtIndexPath:indexPath model:self.tableViewModel];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    EventPlainObject *event = [self.events objectAtIndex:indexPath.row];
    [self.delegate didTapCellWithEvent:event];
}

#pragma mark - Private methods

- (void)setupActionBlocks {
    self.tableViewActions = [[NITableViewActions alloc] initWithTarget:self];
}

- (NIMutableTableViewModel *)updateTableViewModel {
    NSMutableArray *cellObjects = [NSMutableArray array];

    EventPlainObject *nearestEvent = [self.events firstObject];
    
    NSString *eventDay = [self.dateFormatter obtainDateWithDayFormat:nearestEvent.startDate];
    NSString *eventMonth = [self.dateFormatter obtainDateWithMonthFormat:nearestEvent.startDate];
        
    NearestEventTableViewCellObject *nearestEventTableViewCellObject = [NearestEventTableViewCellObject objectWithEvent:nearestEvent eventDay:eventDay eventMonth:eventMonth];
    [cellObjects addObject:nearestEventTableViewCellObject];
    
    for (int i = 1; i < self.events.count; i++) {
        EventPlainObject *event = [self.events objectAtIndex:i];
        eventDay = [self.dateFormatter obtainDateWithDayFormat:event.startDate];
        eventMonth = [self.dateFormatter obtainDateWithMonthFormat:event.startDate];
        
        EventListTableViewCellObject *eventListCellObject = [EventListTableViewCellObject objectWithEvent:event eventDay:eventDay eventMonth:eventMonth];
        [cellObjects addObject:eventListCellObject];
    }
    
    NIMutableTableViewModel *tableViewModel = [[NIMutableTableViewModel alloc] initWithSectionedArray:cellObjects
                                                                      delegate:(id)[NICellFactory class]];

    return tableViewModel;
}

@end
