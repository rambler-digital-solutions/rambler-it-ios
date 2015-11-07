//
//  EventDataDisplayManager.m
//  Conferences
//
//  Created by Karpushin Artem on 04/11/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "EventDataDisplayManager.h"

#import <Nimbus/NimbusModels.h>

#import "EventInfoTableViewCellObject.h"
#import "LectionInfoTableViewCellObject.h"

@interface EventDataDisplayManager () <UITableViewDelegate>

@property (strong, nonatomic) NITableViewModel *tableViewModel;
@property (strong, nonatomic) NITableViewActions *tableViewActions;
@property (strong, nonatomic) PlainEvent *event;

@end

@implementation EventDataDisplayManager

- (void)configureDataDisplayManagerWithEvent:(PlainEvent *)event {
    self.event = event;
}

#pragma mark DataDisplayManager methods

- (id<UITableViewDataSource>)dataSourceForTableView:(UITableView *)tableView {
    if (!self.tableViewModel) {
        self.tableViewModel = [self configureTableViewModel];
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

#pragma mark - Private methods

- (void)setupActionBlocks {
    self.tableViewActions = [[NITableViewActions alloc] initWithTarget:self];
}

- (NITableViewModel *)configureTableViewModel {
    NSMutableArray *cellObjects = [NSMutableArray array];
    NITableViewModel *tableViewModel;
    
    EventInfoTableViewCellObject *event = [EventInfoTableViewCellObject new];
    LectionInfoTableViewCellObject *lection1 = [LectionInfoTableViewCellObject new];
    LectionInfoTableViewCellObject *lection2 = [LectionInfoTableViewCellObject new];
    
    [cellObjects addObject:event];
    [cellObjects addObject:lection1];
    [cellObjects addObject:lection2];
    
    tableViewModel = [[NITableViewModel alloc] initWithSectionedArray:cellObjects
                                                                    delegate:(id)[NICellFactory class]];
    
    return tableViewModel;
}

@end
