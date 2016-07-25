//
//  AnnouncementListAnimator.h
//  Conferences
//
//  Created by Vasyura Anastasiya on 25/07/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NearestAnnouncementTableHeaderView;

/**
 @author Vasyura Anastasiya
 
 Animator for announce table view scrolling
 */
@interface AnnouncementListAnimator : NSObject

@property (weak, nonatomic) IBOutlet NearestAnnouncementTableHeaderView *headerView;

- (void)animateWithContentOffset:(CGPoint)contentOffset;

@end
