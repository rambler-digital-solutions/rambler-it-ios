//
//  AnnouncementGalleryAnnouncementGalleryPresenter.h
//  RamblerConferences
//
//  Created by Egor Tolstoy on 13/08/2016.
//  Copyright © 2016 Rambler&Co. All rights reserved.
//

#import "AnnouncementGalleryViewOutput.h"
#import "AnnouncementGalleryInteractorOutput.h"
#import "AnnouncementGalleryModuleInput.h"

@protocol AnnouncementGalleryViewInput;
@protocol AnnouncementGalleryInteractorInput;
@protocol AnnouncementGalleryRouterInput;

@interface AnnouncementGalleryPresenter : NSObject <AnnouncementGalleryModuleInput, AnnouncementGalleryViewOutput, AnnouncementGalleryInteractorOutput>

@property (nonatomic, weak) id<AnnouncementGalleryViewInput> view;
@property (nonatomic, strong) id<AnnouncementGalleryInteractorInput> interactor;
@property (nonatomic, strong) id<AnnouncementGalleryRouterInput> router;

@end
