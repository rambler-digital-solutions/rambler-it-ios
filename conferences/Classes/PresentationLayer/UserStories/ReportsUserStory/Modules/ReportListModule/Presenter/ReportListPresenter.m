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

@implementation ReportListPresenter

#pragma mark - ReportListViewOutput

- (void)setupView {
    NSArray *events = [self.interactor obtainEventList];
    [self.interactor updateEventList];
    [self.view setupViewWithEventList:events];
}

- (void)didTriggerTapCellWithEvent:(EventPlainObject *)event {
    [self.router openEventModuleWithEventObjectId:event.objectId];
}

#pragma mark - EventListInteractorOutput

- (void)didUpdateEventList:(NSArray *)events {
    [self.view updateViewWithEventList:events];
}

- (void)didSearchBarChangedWithText:(NSString *)text {
    NSPredicate *predicate;
    
    if ([text length] == 0) {
        predicate = nil;
    } else {
        predicate = [NSPredicate predicateWithFormat:@"name CONTAINS[c] %@",text];
    }
    
    NSArray *events = [self.interactor obtainEventListWithPredicate:predicate];
    [self.view updateViewWithEventList:events];
}

@end