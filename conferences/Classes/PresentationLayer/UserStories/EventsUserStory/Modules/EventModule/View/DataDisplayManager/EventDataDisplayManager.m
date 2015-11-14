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
#import "SignUpAndSaveToCalendarEventTableViewCellObject.h"
#import "CurrentVideoTranslationTableViewCellObject.h"
#import "PastVideoTranslationTableViewCellObject.h"
#import "EventDescriptionTableViewCellObject.h"
#import "CellObjectBuilder.h"
#import "EventCellObjectBuilderFactory.h"
#import "PlainEvent.h"

@interface EventDataDisplayManager () <UITableViewDelegate>

@property (strong, nonatomic) NITableViewModel *tableViewModel;
@property (strong, nonatomic) NITableViewActions *tableViewActions;
@property (strong, nonatomic) id <CellObjectBuilder> cellObjectBuilder;
@property (strong, nonatomic) NSArray *cellObjects;

@end

@implementation EventDataDisplayManager

- (void)configureDataDisplayManagerWithEvent:(PlainEvent *)event {
    self.cellObjectBuilder = [self.cellObjectBuilderFactory builderForEventType:@(event.eventType)];
    self.cellObjects = [self.cellObjectBuilder cellObjectsForEvent:event];
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
    NITableViewModel *tableViewModel = [[NITableViewModel alloc] initWithSectionedArray:self.cellObjects
                                                                    delegate:(id)[NICellFactory class]];
    
    return tableViewModel;
}

@end
