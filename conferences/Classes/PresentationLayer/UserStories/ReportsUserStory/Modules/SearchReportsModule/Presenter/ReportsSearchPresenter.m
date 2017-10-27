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

#import "ReportsSearchPresenter.h"
#import "EventPlainObject.h"
#import "LecturePlainObject.h"
#import "SpeakerPlainObject.h"

@interface ReportsSearchPresenter ()

@property (nonatomic, copy) NSString *searchString;

@end

@implementation ReportsSearchPresenter

- (void)configureReportsSearchModuleWithSearchTerm:(NSString *)searchString {
    self.searchString = searchString;
}

#pragma mark - ReportsSearchViewOutput

- (void)setupView {
    [self.moduleOutput didLoadReportsSearchModuleInput:self];
    [self.view setupView];
    [self updateModuleWithSearchTerm:self.searchString];
}

- (void)didTriggerTapCellWithEvent:(EventPlainObject *)event {
    [self.view generateLightImpact];
    [self.router openEventModuleWithEventObjectId:event.eventId];
}

- (void)didTriggerTapCellWithLecture:(LecturePlainObject *)lecture {
    [self.view generateLightImpact];
    [self.router openLectureModuleWithLectureObjectId:lecture.lectureId];
}

- (void)didTriggerTapCellWithSpeaker:(SpeakerPlainObject *)speaker {
    [self.view generateLightImpact];
    [self.router openSpeakerModuleWithSpeakerObjectId:speaker.speakerId];
}

- (void)didTapClearPlaceholderView {
    [self.moduleOutput didTapClearScreenSearchModule];
}

- (void)didSelectTag:(NSString *)tag {
    [self.moduleOutput didSelectSearchString:tag];
}

#pragma mark - ReportsSearchModuleInput

- (void)updateModuleWithSearchTerm:(NSString *)searchText {
    if ([searchText length] == 0) {
        [self.view showClearPlaceholder];
    }
    else {
        NSArray *foundObjects = [self.interactor obtainFoundObjectListWithSearchText:searchText];
        [self.view updateViewWithObjectList:foundObjects searchText:searchText];
    }
}

- (void)closeSearchModule {
    [self.view closeSearchView];
}
@end
