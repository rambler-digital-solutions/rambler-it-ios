//
//  EventView.h
//  Conferences
//
//  Created by Karpushin Artem on 01/11/15.
//  Copyright 2015 Rambler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventViewInput.h"

@protocol EventViewOutput;

@interface EventTableViewController : UIViewController<EventViewInput>

@property (nonatomic, strong) id<EventViewOutput> output;

@end

