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

#import "ReportListDataDisplayManager.h"

#import <Nimbus/NimbusModels.h>

#import "ReportEventTableViewCellObject.h"
#import "TableViewSectionHeaderCellObject.h"
#import "DateFormatter.h"
#import "EventPlainObject.h"
#import "EXTScope.h"
#import "TagModelObject.h"
#import "LecturePlainObject.h"

static NSString *const kSeparatorTagsString = @", ";
static const CGFloat kTagsLineHeight = 3;
static const CGFloat kTitleLineHeight = 3;

@interface ReportListDataDisplayManager () <UITableViewDelegate>

@property (strong, nonatomic) NIMutableTableViewModel *tableViewModel;
@property (strong, nonatomic) NITableViewActions *tableViewActions;
@property (strong, nonatomic) NSArray *events;

@end

@implementation ReportListDataDisplayManager

- (void)updateTableViewModelWithEvents:(NSArray *)events {
    self.events = events;
    [self updateTableViewModel];
    [self.delegate didUpdateTableViewModel];
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

#pragma mark - UITableViewDelegate methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [NICellFactory tableView:tableView heightForRowAtIndexPath:indexPath model:self.tableViewModel];
}

#pragma mark - Private methods


- (void)setupTableViewActions {
    self.tableViewActions = [[NITableViewActions alloc] initWithTarget:self];
    self.tableViewActions.tableViewCellSelectionStyle = UITableViewCellSelectionStyleNone;
    
    @weakify(self);
    NIActionBlock reportTapActionBlock = ^BOOL(ReportEventTableViewCellObject *object, id target, NSIndexPath *indexPath) {
        @strongify(self);
        [self.delegate didTapCellWithEvent:object.event];
        return YES;
    };
    [self.tableViewActions attachToClass:[ReportEventTableViewCellObject class] tapBlock:reportTapActionBlock];
}

- (NSArray *)generateCellObjects {
    NSMutableArray *cellObjects = [NSMutableArray array];
    
    TableViewSectionHeaderCellObject *headerCellObject = [TableViewSectionHeaderCellObject new];
    [cellObjects addObject:headerCellObject];
    
    for (EventPlainObject *event in self.events) {
        NSString *eventDate = [self.dateFormatter obtainDateWithDayMonthYearFormat:event.startDate];
        NSString *eventName = event.name ? event.name : @"";
        NSString *tags = [self obtainTagsStringFromEvent:event];
        NSAttributedString *attributedTags = [self stringWithLineSpacingHeight:kTagsLineHeight text:tags];
        NSAttributedString *eventAttributedName = [self stringWithLineSpacingHeight:kTitleLineHeight text:eventName];

        ReportEventTableViewCellObject *cellObject = [ReportEventTableViewCellObject objectWithEvent:event
                                                                                             andDate:eventDate
                                                                                                tags:attributedTags
                                                                                     highlightedText:eventAttributedName];
        [cellObjects addObject:cellObject];
    }
    
    return cellObjects;
}

- (void)updateTableViewModel {
    NSArray *cellObjects = [self generateCellObjects];
    
    self.tableViewModel = [[NIMutableTableViewModel alloc] initWithSectionedArray:cellObjects
                                                                        delegate:(id)[NICellFactory class]];
}

#pragma mark - private methods

- (NSString *)obtainTagsStringFromEvent:(EventPlainObject *)event {
    NSMutableArray *allTags = [NSMutableArray array];
    for (LecturePlainObject *lecture in event.lectures) {
        [allTags addObjectsFromArray:[lecture.tags allObjects]];
    }
    NSArray *arrayWithoutDuplicates = [[NSSet setWithArray: allTags] allObjects];
    
    NSArray *tagsNames = [arrayWithoutDuplicates valueForKey:TagModelObjectAttributes.name];
    NSString *stringFromTags = [tagsNames count] != 0 ? [tagsNames componentsJoinedByString:kSeparatorTagsString] : @"" ;
    
    return stringFromTags;
}

- (NSAttributedString *)stringWithLineSpacingHeight:(CGFloat)height
                                               text:(NSString *)text {
    NSMutableAttributedString *stringWithLineSpacing = [[NSMutableAttributedString alloc] initWithString:text];
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:height];
    
    [stringWithLineSpacing addAttribute:NSParagraphStyleAttributeName
                              value:style
                              range:NSMakeRange(0, stringWithLineSpacing.length)];
    return [stringWithLineSpacing copy];
    
}

@end
