//
//  SearchReportsPresenter.m
//  Conferences
//
//  Created by k.zinovyev on 16.07.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import "ReportsSearchPresenter.h"
#import "EventPlainObject.h"
#import "LecturePlainObject.h"
#import "SpeakerPlainObject.h"

@implementation ReportsSearchPresenter


- (void)updateModuleWithText:(NSString *)searchText {
    if ([searchText isEqualToString:@""]) {
        [self.view showClearPlaceholder];
    }
    else {
        NSArray *foundObjects = [self.interactor obtainFoundObjectListWithSearchText:searchText];
        [self.view updateViewWithObjectList:foundObjects searchText:searchText];
    }
}

- (void)setupView {
    [self.moduleOutput didLoadReportsSearchModule:self];
    [self.view setupView];
}

- (void)didTriggerTapCellWithEvent:(EventPlainObject *)event {
    [self.router openEventModuleWithEventObjectId:event.objectId];
}
- (void)didTriggerTapCellWithLecture:(LecturePlainObject *)lecture {
    
}

- (void)didTriggerTapCellWithSpeaker:(SpeakerPlainObject *)speaker {
    
}

#pragma mark - EventListInteractorOutput

- (void)didTapClearPlaceholderView {
    [self.moduleOutput didTapClearScreenSearchModule];
}

- (void)closeSearchModule {
    [self.view closeSearchView];
}

@end
