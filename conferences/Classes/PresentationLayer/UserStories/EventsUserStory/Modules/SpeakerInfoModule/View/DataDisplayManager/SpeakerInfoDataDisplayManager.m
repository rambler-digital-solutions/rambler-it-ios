//
//  SpeakerInfoDataDisplayManager.m
//  Conferences
//
//  Created by Karpushin Artem on 16/01/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import "SpeakerInfoDataDisplayManager.h"
#import <Nimbus/NimbusModels.h>

#import "SpeakerPlainObject.h"

@interface SpeakerInfoDataDisplayManager ()

@property (strong, nonatomic) NITableViewModel *tableViewModel;
@property (strong, nonatomic) NITableViewActions *tableViewActions;
@property (strong, nonatomic) SpeakerPlainObject *speaker;

@end

@implementation SpeakerInfoDataDisplayManager

#pragma mark - Public methods

- (void)configureDataDisplayManagerWithSpeaker:(SpeakerPlainObject *)speaker {
    self.speaker = speaker;
}

#pragma mark - UITableViewDelegate methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [NICellFactory tableView:tableView heightForRowAtIndexPath:indexPath model:self.tableViewModel];
}

#pragma mark - DataDisplayManager methods

- (id<UITableViewDataSource>)dataSourceForTableView:(UITableView *)tableView {
    if (!self.tableViewModel) {
        [self updateTableViewModel];
    }
    return self.tableViewModel;
}

- (id<UITableViewDelegate>)delegateForTableView:(UITableView *)tableView withBaseDelegate:(id<UITableViewDelegate>)baseTableViewDelegate {
    if (!self.tableViewActions) {
        [self setupTableViewActions];
    }
    return [self.tableViewActions forwardingTo:self];
}

#pragma mark - Private methods

- (NSArray *)generateCellObjects {
    NSMutableArray *cellObjects = [@[] mutableCopy];
    
    return cellObjects;
}

- (void)updateTableViewModel {
    NSArray *cellObjects = [self generateCellObjects];
    
    self.tableViewModel = [[NITableViewModel alloc] initWithSectionedArray:cellObjects delegate:(id)[NICellFactory class]];
}

- (void)setupTableViewActions {
    self.tableViewActions = [[NITableViewActions alloc] initWithTarget:self];
}

@end
