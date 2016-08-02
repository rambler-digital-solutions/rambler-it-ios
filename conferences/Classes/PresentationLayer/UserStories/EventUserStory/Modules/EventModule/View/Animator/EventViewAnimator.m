//
//  EventViewAnimator.m
//  Conferences
//
//  Created by Vasyura Anastasiya on 26/07/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import "EventViewAnimator.h"
#import "EventHeaderView.h"

static CGFloat const kEventTopConstraintConstant = 0.0;
static CGFloat const kAnnouncementImageMaxScaleConstant = 2.0;
static CGFloat const kAnnouncementImageMinScaleConstant = 1.0;

@implementation EventViewAnimator

- (void)animateWithContentOffset:(CGPoint)contentOffset {
    CGFloat offset = contentOffset.y;
    if (offset < 0) {
        self.headerView.topConstraint.constant = kEventTopConstraintConstant + contentOffset.y;
        CGFloat height = self.headerView.bounds.size.height;
        CGFloat scale = -offset / height * (kAnnouncementImageMaxScaleConstant -kAnnouncementImageMinScaleConstant) + kAnnouncementImageMinScaleConstant;
        CGFloat normalizeScale = MIN(scale, kAnnouncementImageMaxScaleConstant);
        self.headerView.eventImageView.transform = CGAffineTransformMakeScale(normalizeScale, normalizeScale);
    }
    
    self.tableView.clipsToBounds = offset > self.headerView.bounds.size.height;
}

@end
