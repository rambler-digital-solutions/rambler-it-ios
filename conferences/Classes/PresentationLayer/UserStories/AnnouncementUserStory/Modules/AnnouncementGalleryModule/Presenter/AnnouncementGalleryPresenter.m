//
//  AnnouncementGalleryAnnouncementGalleryPresenter.m
//  RamblerConferences
//
//  Created by Egor Tolstoy on 13/08/2016.
//  Copyright © 2016 Rambler&Co. All rights reserved.
//

#import "AnnouncementGalleryPresenter.h"

#import "AnnouncementGalleryViewInput.h"
#import "AnnouncementGalleryInteractorInput.h"
#import "AnnouncementGalleryRouterInput.h"

@implementation AnnouncementGalleryPresenter

#pragma mark - Методы AnnouncementGalleryModuleInput

- (void)configureModule {
    // Стартовая конфигурация модуля, не привязанная к состоянию view
}

#pragma mark - Методы AnnouncementGalleryViewOutput

- (void)didTriggerViewReadyEvent {
	[self.view setupInitialState];
}

#pragma mark - Методы AnnouncementGalleryInteractorOutput

@end
