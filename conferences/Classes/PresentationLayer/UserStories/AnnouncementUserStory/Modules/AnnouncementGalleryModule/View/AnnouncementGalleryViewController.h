//
//  AnnouncementGalleryAnnouncementGalleryViewController.h
//  RamblerConferences
//
//  Created by Egor Tolstoy on 13/08/2016.
//  Copyright © 2016 Rambler&Co. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AnnouncementGalleryViewInput.h"

@protocol AnnouncementGalleryViewOutput;

@interface AnnouncementGalleryViewController : UIViewController <AnnouncementGalleryViewInput>

@property (nonatomic, strong) id<AnnouncementGalleryViewOutput> output;

@end
