//
//  EventListDataDisplayManager.h
//  Conferences
//
//  Created by Karpushin Artem on 25/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "DataDisplayManager.h"

@class PlainEvent;
@class DateFormatter;

@protocol EventLIstDataDisplayManagerDelegate

- (void)didUpdateTableViewModel;
- (void)didTapCellWithEvent:(PlainEvent *)event;

@end

@interface EventListDataDisplayManager : NSObject <DataDisplayManager>

@property (weak, nonatomic) id <EventLIstDataDisplayManagerDelegate> delegate;
@property (strong, nonatomic) DateFormatter *dateFormatter;

- (void)updateTableViewModelWithEvents:(NSArray *)events;

@end

