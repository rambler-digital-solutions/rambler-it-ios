//
//  EventListView.h
//  Conferences
//
//  Created by Karpushin Artem on 12/10/15.
//  Copyright 2015 Rambler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventListViewInput.h"

@protocol EventListViewOutput;
@class EventListDataDisplayManager;

@interface EventListTableViewController : UITableViewController <EventListViewInput>

@property (nonatomic, strong) id<EventListViewOutput> output;
@property (strong, nonatomic) EventListDataDisplayManager *dataDisplayManager;

@end

