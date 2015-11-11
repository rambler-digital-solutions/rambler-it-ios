//
//  ReportListViewInput.h
//  Conferences
//
//  Created by Karpushin Artem on 08/11/15.
//  Copyright 2015 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ReportListViewInput <NSObject>

- (void)setupViewWithEventList:(NSArray *)events;
- (void)updateViewWithEventList:(NSArray *)events;

@end

