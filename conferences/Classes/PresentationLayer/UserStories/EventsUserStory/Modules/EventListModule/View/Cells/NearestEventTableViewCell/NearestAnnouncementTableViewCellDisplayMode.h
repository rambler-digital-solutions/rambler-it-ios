//
//  NearestAnnouncementTableViewCellDisplayMode.h
//  Conferences
//
//  Created by Karpushin Artem on 20/03/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#ifndef NearestAnnouncementTableViewCellDisplayMode_h
#define NearestAnnouncementTableViewCellDisplayMode_h

/**
 @author Artem Karpushin
 
 NearestAnnouncementTableViewCell display mode
 */
typedef NS_ENUM(NSUInteger, NearestAnnouncementTableViewCellDisplayMode) {
    /**
     @author Artem Karpushin
     
     When we have only one announcement
     */
    NearestAnnouncementTableViewCellDisplayModeDefault,
    /**
     @author Artem Karpushin
     
     When we have 2 or more
     */
    NearestAnnouncementTableViewCellDisplayModeShortcut
};

#endif /* NearestAnnouncementTableViewCellDisplayMode_h */
