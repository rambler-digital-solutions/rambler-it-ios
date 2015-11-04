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

typedef NS_ENUM(NSUInteger, CellObjectID){
    
    FutureEventTableViewCellObjectID = 0
};

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

- (void)updateCellWithEvent:(PlainEvent *)event {
    FutureEventTableViewCellObject *futureEventTableViewCellObject = [FutureEventTableViewCellObject objectWithElementID:FutureEventTableViewCellObjectID event:event];
    
}

#pragma mark - DataDisplayManager methods

- (id<UITableViewDataSource>)dataSourceForTableView:(UITableView *)tableView {
    if (!self.tableViewModel) {
        self.tableViewModel = [self updateTableViewModel];
        //self.tableViewModel = [self initialTableViewModel];
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

- (NIMutableTableViewModel *)updateTableViewModel {
    NSMutableArray *cellObjects = [NSMutableArray array];
    NIMutableTableViewModel *tableViewModel;
    if (self.events.count > 0) {
        PlainEvent *futureEvent = [self.events firstObject];
        
        FutureEventTableViewCellObject *futureEventTableViewCellObject = [FutureEventTableViewCellObject objectWithElementID:FutureEventTableViewCellObjectID event:futureEvent];
        [cellObjects addObject:futureEventTableViewCellObject];
        
        for (int i = 1; i < self.events.count; i++) {
            PastEventTableViewCellObject *cellObject = [PastEventTableViewCellObject objectWithElementID:i event:self.events[i]];
            [cellObjects addObject:cellObject];
        }
        
        tableViewModel = [[NIMutableTableViewModel alloc] initWithSectionedArray:cellObjects
                                                                      delegate:(id)[NICellFactory class]];
    } else {
        // если нет ивентов вернуть что-то
    }
    return tableViewModel;
}



//- (NITableViewModel *)initialTableViewModel {
//    NSArray *cellObjects = [self initializingArray];
//    NITableViewModel *tableViewModel = [[NITableViewModel alloc] initWithSectionedArray:cellObjects
//                                                                               delegate:(id)[NICellFactory class]];
//    return tableViewModel;
//}
//
//- (NSArray *)initializingArray {
//    NSMutableArray *cellObjects = [NSMutableArray array];
//    
//    PlainEvent *event1 = [PlainEvent new];
//    PlainEvent *event2 = [PlainEvent new];
//    event1.name = @"Rambler iOS #1";
//    event1.tags = @"Viper, TDD";
//    event1.startDate = [NSDate date];
//    event2.name = @"Rambler iOS #2";
//    event2.tags = @"Fonts, Swift";
//    event2.startDate = [NSDate date];
//    
//    PlainEvent *futureEvent = [PlainEvent new];
//    futureEvent.name = @"Rambler iOS #3";
//    futureEvent.startDate = [NSDate date];
//    futureEvent.image = [UIImage imageNamed:@"placeholder"];
//    
//    PastEventTableViewCellObject *cellObject = [PastEventTableViewCellObject objectWithElementID:0 event:event1];
//    PastEventTableViewCellObject *cellObject1 = [PastEventTableViewCellObject objectWithElementID:1 event:event2];
//    
//    FutureEventTableViewCellObject *celloObject2 = [FutureEventTableViewCellObject objectWithElementID:2 event:futureEvent];
//    
//    
//    [cellObjects addObject:celloObject2];
//    [cellObjects addObject:cellObject];
//    [cellObjects addObject:cellObject1];
//    
//    return cellObjects;
//}

@end
