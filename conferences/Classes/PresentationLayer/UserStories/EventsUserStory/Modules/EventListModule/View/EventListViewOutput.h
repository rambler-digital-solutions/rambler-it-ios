//
//  EventListViewOutput.h
//  Conferences
//
//  Created by Karpushin Artem on 12/10/15.
//  Copyright 2015 Rambler. All rights reserved.
//
#import <Foundation/Foundation.h>

@class PlainEvent;

@protocol EventListViewOutput <NSObject>

- (void)setupView;
- (void)didTriggerTapCellWithEvent:(PlainEvent *)event;

@end

