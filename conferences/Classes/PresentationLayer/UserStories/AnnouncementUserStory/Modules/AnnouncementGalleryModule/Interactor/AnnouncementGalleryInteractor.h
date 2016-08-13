//
//  AnnouncementGalleryAnnouncementGalleryInteractor.h
//  RamblerConferences
//
//  Created by Egor Tolstoy on 13/08/2016.
//  Copyright © 2016 Rambler&Co. All rights reserved.
//

#import "AnnouncementGalleryInteractorInput.h"

@protocol AnnouncementGalleryInteractorOutput;

@interface AnnouncementGalleryInteractor : NSObject <AnnouncementGalleryInteractorInput>

@property (nonatomic, weak) id<AnnouncementGalleryInteractorOutput> output;

@end
