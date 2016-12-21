//
//  TVEventListModuleTVEventListModulePresenter.m
//  Conferences
//
//  Created by Porokhov Artem on 21/12/2016.
//  Copyright © 2016 Rambler&Co. All rights reserved.
//

#import "TVEventListModulePresenter.h"

#import "TVEventListModuleViewInput.h"
#import "TVEventListModuleInteractorInput.h"
#import "TVEventListModuleRouterInput.h"

@implementation TVEventListModulePresenter

#pragma mark - Методы TVEventListModuleModuleInput

- (void)configureModule {
    // Стартовая конфигурация модуля, не привязанная к состоянию view
}

#pragma mark - Методы TVEventListModuleViewOutput

- (void)didTriggerViewReadyEvent {
	[self.view setupInitialState];
}

#pragma mark - Методы TVEventListModuleInteractorOutput

@end
