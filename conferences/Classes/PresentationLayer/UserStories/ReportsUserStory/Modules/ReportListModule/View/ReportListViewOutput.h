//
//  ReportListViewOutput.h
//  Conferences
//
//  Created by Karpushin Artem on 08/11/15.
//  Copyright 2015 Rambler. All rights reserved.
//
#import <Foundation/Foundation.h>

@class PlainEvent;

@protocol ReportListViewOutput <NSObject>

- (void)setupView;
- (void)didTriggerTapCellWithEvent:(PlainEvent *)event;

@end

