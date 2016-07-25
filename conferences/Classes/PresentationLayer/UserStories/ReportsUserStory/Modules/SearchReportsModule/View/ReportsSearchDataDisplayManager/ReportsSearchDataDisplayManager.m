//
//  ReportsSearchDataDisplayManager.m
//  Conferences
//
//  Created by k.zinovyev on 16.07.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import "ReportsSearchDataDisplayManager.h"


#import <Nimbus/NimbusModels.h>

#import "ReportEventTableViewCellObject.h"
#import "ReportLectureTableViewCellObject.h"
#import "ReportSpeakerTableViewCellObject.h"
#import "TableViewSectionHeaderCellObject.h"
#import "EventPlainObject.h"
#import "LecturePlainObject.h"
#import "SpeakerPlainObject.h"
#import "EXTScope.h"
#import "ReportsSearchCellObjectsDirector.h"

@interface ReportsSearchDataDisplayManager () <UITableViewDelegate>

@property (strong, nonatomic) NIMutableTableViewModel *tableViewModel;
@property (strong, nonatomic) NITableViewActions *tableViewActions;
@property (strong, nonatomic) NSArray *foundObjects;

@end

@implementation ReportsSearchDataDisplayManager

- (instancetype)initWithCellObjectDirector:(id<ReportsSearchCellObjectsDirector>)director {
    self = [super init];
    if (self) {
        _director = director;
    }
    return self;
}

- (void)updateTableViewModelWithObjects:(NSArray *)foundObjects searchText:(NSString *)searchText{
    self.foundObjects = foundObjects;
    [self updateTableViewModelWithSelectedText:searchText];
    [self.delegate didUpdateTableViewModel];
}

#pragma mark - DataDisplayManager methods

- (id<UITableViewDataSource>)dataSourceForTableView:(UITableView *)tableView {
    if (!self.tableViewModel) {
        [self updateTableViewModelWithSelectedText:nil];
    }
    return self.tableViewModel;
}

- (id<UITableViewDelegate>)delegateForTableView:(UITableView *)tableView withBaseDelegate:(id<UITableViewDelegate>)baseTableViewDelegate {
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
    NIActionBlock reportTapActionEventBlock = ^BOOL(ReportEventTableViewCellObject *object, id target, NSIndexPath *indexPath) {
        @strongify(self);
        [self.delegate didTapCellWithEvent:object.event];
        return YES;
    };
    NIActionBlock reportTapActionLectureBlock = ^BOOL(ReportLectureTableViewCellObject *object, id target, NSIndexPath *indexPath) {
        @strongify(self);
        [self.delegate didTapCellWithLecture:object.lecture];
        return YES;
    };
    NIActionBlock reportTapActionSpeakerBlock = ^BOOL(ReportSpeakerTableViewCellObject *object, id target, NSIndexPath *indexPath) {
        @strongify(self);
        [self.delegate didTapCellWithSpeaker:object.speaker];
        return YES;
    };
    
    [self.tableViewActions attachToClass:[ReportEventTableViewCellObject class] tapBlock:reportTapActionEventBlock];
    [self.tableViewActions attachToClass:[ReportLectureTableViewCellObject class] tapBlock:reportTapActionLectureBlock];
    [self.tableViewActions attachToClass:[ReportSpeakerTableViewCellObject class] tapBlock:reportTapActionSpeakerBlock];
}

- (NSArray *)generateCellObjectsWithSelectedText:(NSString *)selectedText {
    
    NSArray *cellObjects = [self.director generateCellObjectsFromPlainObjects:self.foundObjects selectedText:selectedText];
    
    return cellObjects;
}

- (void)updateTableViewModelWithSelectedText:(NSString *)selectedText {
    NSArray *cellObjects = [self generateCellObjectsWithSelectedText:selectedText];
    
    self.tableViewModel = [[NIMutableTableViewModel alloc] initWithSectionedArray:cellObjects
                                                                         delegate:(id)[NICellFactory class]];
}

@end
