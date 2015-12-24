//
//  EventHeaderView.m
//  Conferences
//
//  Created by Karpushin Artem on 10/12/15.
//  Copyright 2015 Rambler. All rights reserved.
//

#import "EventHeaderView.h"
#import "EventHeaderViewOutput.h"
#import "PlainEvent.h"

#import <SDWebImage/UIImageView+WebCache.h>

static NSString *const kPlaceholderImageName = @"placeholder";

@implementation EventHeaderView

+ (EventHeaderView *)eventHeaderView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class])
                                          owner:self
                                        options:NULL] firstObject];
}

#pragma mark - EventHeaderViewInput

- (void)configureViewWithEvent:(PlainEvent *)event {
    self.backgroundColor = event.backgroundColor;
    [self.eventImageView sd_setImageWithURL:event.imageUrl
                           placeholderImage:[UIImage imageNamed:kPlaceholderImageName]];
}

@end