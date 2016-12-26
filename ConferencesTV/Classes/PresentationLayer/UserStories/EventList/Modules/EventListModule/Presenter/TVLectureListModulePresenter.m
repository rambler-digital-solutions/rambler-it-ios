//
//  TVLectureListModuleTVLectureListModulePresenter.m
//  Conferences
//
//  Created by Porokhov Artem on 21/12/2016.
//  Copyright © 2016 Rambler&Co. All rights reserved.
//

#import "TVLectureListModulePresenter.h"

#import "TVLectureListModuleViewInput.h"
#import "TVLectureListModuleInteractorInput.h"
#import "TVLectureListModuleRouterInput.h"

@implementation TVLectureListModulePresenter

#pragma mark - Методы TVLectureListModuleModuleInput

- (void)configureModule {
    // Стартовая конфигурация модуля, не привязанная к состоянию view
}

#pragma mark - Методы TVLectureListModuleViewOutput

- (void)didTriggerViewReadyEvent {
	[self.view setupInitialState];
}

#pragma mark - Методы TVLectureListModuleInteractorOutput

@end
