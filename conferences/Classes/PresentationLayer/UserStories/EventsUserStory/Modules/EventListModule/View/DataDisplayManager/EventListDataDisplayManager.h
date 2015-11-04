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

@end

@interface EventListDataDisplayManager : NSObject <DataDisplayManager>

@property (weak, nonatomic) id <EventLIstDataDisplayManagerDelegate> delegate;

- (void)configureDataDisplayManagerWithEvents:(NSArray *)events;
- (void)updateTableViewModelWithEvents:(NSArray *)events;
- (void)updateCellWithEvent:(PlainEvent *)event;

@end

