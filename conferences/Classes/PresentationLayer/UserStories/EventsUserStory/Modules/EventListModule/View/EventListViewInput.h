//
//  EventListViewInput.h
//  Conferences
//
//  Created by Karpushin Artem on 12/10/15.
//  Copyright 2015 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PlainEvent;

@protocol EventListViewInput <NSObject>

- (void)setupViewWithEventList:(NSArray *)events;
- (void)updateViewWithEventList:(NSArray *)events;
- (void)updateCellWithEvent:(PlainEvent *)event;

@end

