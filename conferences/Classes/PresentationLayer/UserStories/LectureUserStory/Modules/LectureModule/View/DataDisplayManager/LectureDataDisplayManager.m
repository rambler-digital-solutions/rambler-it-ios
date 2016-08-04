// Copyright (c) 2016 RAMBLER&Co
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

#import <Nimbus/NimbusModels.h>
#import "LectureDataDisplayManager.h"
#import "LecturePlainObject.h"
#import "EventPlainObject.h"
#import "TableViewCellWithTextLabelCellObject.h"
#import "LectureDescriptionTableViewCellObject.h"
#import "LectureInfoTableViewCellObject.h"
#import "DateFormatter.h"
#import "TableViewCellWithTextLabelCellObject.h"
#import "TableViewCellWithTextLabelAndImageViewCellObject.h"
#import "VideoRecordTableViewCellObject.h"
#import "LocalizedStrings.h"

static NSString *const kPresentationImageName = @"";
static NSString *const kArticleImageName = @"";
static NSString *const kCodeGithubImageName = @"";

@interface LectureDataDisplayManager ()

@property (strong, nonatomic) NITableViewModel *tableViewModel;
@property (strong, nonatomic) NITableViewActions *tableViewActions;
@property (strong, nonatomic) LecturePlainObject *lecture;

@end

@implementation LectureDataDisplayManager

#pragma mark - Public methods

- (void)configureDataDisplayManagerWithLecture:(LecturePlainObject *)lecture {
    self.lecture = lecture;
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
    LectureInfoTableViewCellObject *lectureDescriptionCellObject = [LectureInfoTableViewCellObject objectWithLecture:self.lecture];

    TableViewCellWithTextLabelCellObject *videoRecordTextLabelCellObject = [TableViewCellWithTextLabelCellObject objectWithText:NSLocalizedString(VideoRecordTableViewCellTitle, nil)];
    
    VideoRecordTableViewCellObject *videoRecorTableViewCellObject = [VideoRecordTableViewCellObject new];
    
    TableViewCellWithTextLabelCellObject *materialsTextLabelCellObject = [TableViewCellWithTextLabelCellObject objectWithText:NSLocalizedString(LectureMaterialsTableViewCellTitle, nil)];
    
    TableViewCellWithTextLabelCellObject *additionalTextLabelCellObject = [TableViewCellWithTextLabelCellObject objectWithText:NSLocalizedString(AdditionInformationTableViewCellTitle, nil)];
    
    UIImage *presentationImage = [UIImage imageNamed:kPresentationImageName];
    TableViewCellWithTextLabelAndImageViewCellObject *presentationTextImageLabelCellObject = [TableViewCellWithTextLabelAndImageViewCellObject objectWithText:NSLocalizedString(LecturePresentationTableViewCellTitle, nil) andImage:presentationImage];
    
    UIImage *articleImage = [UIImage imageNamed:kArticleImageName];
    TableViewCellWithTextLabelAndImageViewCellObject *articlesTextImageLabelCellObject = [TableViewCellWithTextLabelAndImageViewCellObject objectWithText:NSLocalizedString(LectureArticlesTableViewCellTitle, nil) andImage:articleImage];
    
    UIImage *codeGithubImage = [UIImage imageNamed:kCodeGithubImageName];
    TableViewCellWithTextLabelAndImageViewCellObject *codeGithubTextLabelCellObject = [TableViewCellWithTextLabelAndImageViewCellObject objectWithText:NSLocalizedString(LectureCodeGithubTableViewCellTitle, nil) andImage:codeGithubImage];
    
    return @[lectureDescriptionCellObject, videoRecordTextLabelCellObject, videoRecorTableViewCellObject, materialsTextLabelCellObject, presentationTextImageLabelCellObject, articlesTextImageLabelCellObject, additionalTextLabelCellObject, codeGithubTextLabelCellObject];
}

- (void)updateTableViewModel {
    NSArray *cellObjects = [self generateCellObjects];
    
    self.tableViewModel = [[NITableViewModel alloc] initWithSectionedArray:cellObjects delegate:(id)[NICellFactory class]];
}

- (void)setupTableViewActions {
    self.tableViewActions = [[NITableViewActions alloc] initWithTarget:self];
}

@end
