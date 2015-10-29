//
//  EventListDataDisplayManager.m
//  Conferences
//
//  Created by Karpushin Artem on 25/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "EventListDataDisplayManager.h"

#import <Nimbus/NimbusModels.h>

#import "PastEventTableViewCellObject.h"
#import "FutureEventTableViewCellObject.h"

#import "PlainEvent.h"

@interface EventListDataDisplayManager ()

@property (strong, nonatomic) NITableViewModel *tableViewModel;
@property (strong, nonatomic) NITableViewActions *tableViewActions;

@end

@implementation EventListDataDisplayManager

#pragma mark - DataDisplayManager methods

- (id<UITableViewDataSource>)dataSourceForTableView:(UITableView *)tableView {
    
    if (!self.tableViewModel) {
        self.tableViewModel = [self initialTableViewModel];
    }
    return self.tableViewModel;
}

- (id<UITableViewDelegate>)delegateForTableView:(UITableView *)tableView withBaseDelegate:(id<UITableViewDelegate>)baseTableViewDelegate {
    
    
    return baseTableViewDelegate;
}

#pragma mark - Private methods

- (NITableViewModel *)initialTableViewModel {
    NSArray *cellObjects = [self initializingArray];
    NITableViewModel *tableViewModel = [[NITableViewModel alloc] initWithSectionedArray:cellObjects
                                                                               delegate:(id)[NICellFactory class]];
    return tableViewModel;
}

- (NSArray *)initializingArray {
    NSMutableArray *cellObjects = [NSMutableArray array];
    
    PlainEvent *event1 = [PlainEvent new];
    PlainEvent *event2 = [PlainEvent new];
    event1.name = @"Rambler iOS #1";
    event1.eventTags = @"Viper, TDD";
    event1.startDate = [NSDate date];
    event2.name = @"Rambler iOS #2";
    event2.eventTags = @"Fonts, Swift";
    event2.startDate = [NSDate date];
    
    PastEventTableViewCellObject *cellObject = [PastEventTableViewCellObject objectWithElementID:0 event:event1];
    PastEventTableViewCellObject *cellObject1 = [PastEventTableViewCellObject objectWithElementID:1 event:event2];
    
    FutureEventTableViewCellObject *celloObject2 = [FutureEventTableViewCellObject new];
    
    [cellObjects addObject:celloObject2];
    [cellObjects addObject:cellObject];
    [cellObjects addObject:cellObject1];
//    CGFloat height = [NICellFactory tableView:nil heightForRowAtIndexPath:nil model:self.model]
    
    return cellObjects;
}

@end
