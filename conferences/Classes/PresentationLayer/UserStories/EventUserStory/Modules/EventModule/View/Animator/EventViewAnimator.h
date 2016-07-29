//
//  EventViewAnimator.h
//  Conferences
//
//  Created by Vasyura Anastasiya on 26/07/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EventHeaderView;

/**
 @author Vasyura Anastasiya
 
 Animator for detailed event table view scrolling
 */
@interface EventViewAnimator : NSObject

@property (weak, nonatomic) IBOutlet EventHeaderView *headerView;

- (void)animateWithContentOffset:(CGPoint)contentOffset;

@end
