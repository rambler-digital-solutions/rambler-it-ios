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

@protocol EventLIstDataDisplayManagerDelegate

- (void)didUpdateTableViewModel;
- (void)didTapCellWithEvent:(PlainEvent *)event;

@end

@interface EventListDataDisplayManager : NSObject <DataDisplayManager>

@property (weak, nonatomic) id <EventLIstDataDisplayManagerDelegate> delegate;

- (void)updateTableViewModelWithEvents:(NSArray *)events;

@end

