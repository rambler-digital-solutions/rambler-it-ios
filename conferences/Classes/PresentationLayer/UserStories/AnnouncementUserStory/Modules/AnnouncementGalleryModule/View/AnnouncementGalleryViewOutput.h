//
//  AnnouncementGalleryAnnouncementGalleryViewOutput.h
//  RamblerConferences
//
//  Created by Egor Tolstoy on 13/08/2016.
//  Copyright © 2016 Rambler&Co. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AnnouncementGalleryViewOutput <NSObject>

/**
 @author Egor Tolstoy

 Метод сообщает презентеру о том, что view готова к работе
 */
- (void)didTriggerViewReadyEvent;

@end
