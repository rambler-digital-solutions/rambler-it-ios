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
@protocol DataDisplayManager;

@interface EventViewController : UIViewController <EventViewInput>

@property (nonatomic, strong) id<EventViewOutput> output;
@property (strong, nonatomic) id <DataDisplayManager> dataDisplayManager;

@end

