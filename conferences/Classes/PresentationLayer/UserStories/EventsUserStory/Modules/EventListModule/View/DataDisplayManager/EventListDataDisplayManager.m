//
//  EventListDataDisplayManager.m
//  Conferences
//
//  Created by Karpushin Artem on 25/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "EventListDataDisplayManager.h"

#import <Nimbus/NimbusModels.h>

#import "EventListTableViewCellObject.h"
#import "NearestEventTableViewCellObject.h"
#import "PlainEvent.h"
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
    PlainEvent *event = [self.events objectAtIndex:indexPath.row];
    [self.delegate didTapCellWithEvent:event];
}

#pragma mark - Private methods

- (void)setupActionBlocks {
    self.tableViewActions = [[NITableViewActions alloc] initWithTarget:self];
}

- (NIMutableTableViewModel *)updateTableViewModel {
    NSMutableArray *cellObjects = [NSMutableArray array];

    PlainEvent *nearestEvent = [self.events firstObject];
    
    NSString *eventDay = [self.dateFormatter obtainDateWithDayFormat:nearestEvent.startDate];
    NSString *eventMonth = [self.dateFormatter obtainDateWithMonthFormat:nearestEvent.startDate];
        
    NearestEventTableViewCellObject *nearestEventTableViewCellObject = [NearestEventTableViewCellObject objectWithEvent:nearestEvent eventDay:eventDay eventMonth:eventMonth];
    [cellObjects addObject:nearestEventTableViewCellObject];
    
    for (PlainEvent *event in self.events) {
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
