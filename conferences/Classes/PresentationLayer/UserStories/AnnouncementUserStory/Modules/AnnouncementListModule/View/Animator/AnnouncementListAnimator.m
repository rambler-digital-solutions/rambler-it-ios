//
//  AnnouncementListAnimator.m
//  Conferences
//
//  Created by Vasyura Anastasiya on 25/07/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import "AnnouncementListAnimator.h"
#import "NearestAnnouncementTableHeaderView.h"

static CGFloat const kAnnouncementTopConstraintConstant = -20.0;
static CGFloat const kAnnouncementImageMaxScaleConstant = 2.0;
static CGFloat const kAnnouncementImageMinScaleConstant = 1.0;

@implementation AnnouncementListAnimator

- (void)animateWithContentOffset:(CGPoint)contentOffset {
    CGFloat offset = contentOffset.y - kAnnouncementTopConstraintConstant;
    if (offset < 0) {
        self.headerView.topConstraint.constant = kAnnouncementTopConstraintConstant + contentOffset.y;
        CGFloat height = self.headerView.bounds.size.height;
        CGFloat scale = -offset / height * (kAnnouncementImageMaxScaleConstant -kAnnouncementImageMinScaleConstant) + kAnnouncementImageMinScaleConstant;
        CGFloat normalizeScale = MIN(scale, kAnnouncementImageMaxScaleConstant);
        self.headerView.eventImageView.transform = CGAffineTransformMakeScale(normalizeScale, normalizeScale);
    }
}

@end
