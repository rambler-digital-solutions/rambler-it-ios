//
//  AnnouncementGalleryAnnouncementGalleryAssembly_Testable.h
//  RamblerConferences
//
//  Created by Egor Tolstoy on 13/08/2016.
//  Copyright © 2016 Rambler&Co. All rights reserved.
//

#import "AnnouncementGalleryAssembly.h"

@class AnnouncementGalleryViewController;
@class AnnouncementGalleryInteractor;
@class AnnouncementGalleryPresenter;
@class AnnouncementGalleryRouter;

@interface AnnouncementGalleryAssembly ()

- (AnnouncementGalleryViewController *)viewAnnouncementGalleryModule;
- (AnnouncementGalleryPresenter *)presenterAnnouncementGalleryModule;
- (AnnouncementGalleryInteractor *)interactorAnnouncementGalleryModule;
- (AnnouncementGalleryRouter *)routerAnnouncementGalleryModule;

@end
