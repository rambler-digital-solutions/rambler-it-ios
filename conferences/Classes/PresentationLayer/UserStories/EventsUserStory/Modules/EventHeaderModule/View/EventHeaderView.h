//
//  EventHeaderView.h
//  Conferences
//
//  Created by Karpushin Artem on 10/12/15.
//  Copyright 2015 Rambler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventHeaderViewInput.h"

@protocol EventHeaderViewOutput;
@protocol EventHeaderModuleInput;

@interface EventHeaderView : UIView <EventHeaderViewInput, EventHeaderModuleInput>

@property (weak, nonatomic) IBOutlet UIImageView *eventImageView;

@property (nonatomic, strong) id<EventHeaderViewOutput> output;

+ (EventHeaderView *)eventHeaderView;

@end

