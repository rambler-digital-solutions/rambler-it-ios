//
//  ReportListDataDisplayManager.m
//  Conferences
//
//  Created by Karpushin Artem on 08/11/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "ReportListDataDisplayManager.h"

#import <Nimbus/NimbusModels.h>

#import "ReportListTableViewCellObject.h"

@interface ReportListDataDisplayManager () <UITableViewDelegate>

@property (strong, nonatomic) NIMutableTableViewModel *tableViewModel;
@property (strong, nonatomic) NITableViewActions *tableViewActions;
@property (strong, nonatomic) NSArray *events;

@end

@implementation ReportListDataDisplayManager

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
    NIMutableTableViewModel *tableViewModel;
    
    if (self.events.count > 0) {
        
        for (int i = 0; i < self.events.count; i++) {
            ReportListTableViewCellObject *cellObject = [ReportListTableViewCellObject objectWithElementID:i event:self.events[i]];
            [cellObjects addObject:cellObject];
        }
    }
    
    tableViewModel = [[NIMutableTableViewModel alloc] initWithSectionedArray:cellObjects
                                                                        delegate:(id)[NICellFactory class]];
    return tableViewModel;
}


@end
