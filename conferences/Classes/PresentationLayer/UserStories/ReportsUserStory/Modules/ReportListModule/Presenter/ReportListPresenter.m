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

#import "ReportListPresenter.h"
#import "ReportListViewInput.h"
#import "ReportListInteractorInput.h"
#import "ReportListRouterInput.h"
#import "EventPlainObject.h"
#import "ReportsSearchModuleInput.h"

@implementation ReportListPresenter

#pragma mark - ReportListViewOutput

- (void)setupView {
    NSArray *suggests = [self.interactor obtainSuggests];
    [self.router configureReportsSearchModuleWithModuleOutput:self];
    [self.view setupViewWithSuggests:suggests];
}

- (void)didTriggerTapCellWithEvent:(EventPlainObject *)event {
    [self.router openEventModuleWithEventObjectId:event.eventId];
}

- (void)didTapSearchBarCancelButton {
    [self.reportsSearchModule closeSearchModule];
}

- (void)didTapSuggestWithText:(NSString *)text {
    [self.reportsSearchModule updateModuleWithSearchTerm:text];
    [self.view showSearchModuleView];
     [self.view updateSearchBarWithText:text];
}

#pragma mark - SearchBar Delegate

- (void)didChangeSearchBarWithSearchTerm:(NSString *)text {
    [self.reportsSearchModule updateModuleWithSearchTerm:text];
    [self.view showSearchModuleView];
}

- (void)didTapClearScreenSearchModule {
    [self.view hideSearchModuleView];
}

#pragma mark - ReportsSearchModuleOuput

- (void)didLoadReportsSearchModuleInput:(id<ReportsSearchModuleInput>)reportsSearchModule {
    self.reportsSearchModule = reportsSearchModule;
}

@end