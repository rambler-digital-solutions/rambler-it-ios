//
//  ReportListDataDisplayManager.h
//  Conferences
//
//  Created by Karpushin Artem on 08/11/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "DataDisplayManager.h"

@class PlainEvent;

@protocol ReportListDataDisplayManagerDelegate

- (void)didUpdateTableViewModel;
- (void)didTapCellWithEvent:(PlainEvent *)event;

@end

@interface ReportListDataDisplayManager : NSObject <DataDisplayManager>

@property (weak, nonatomic) id <ReportListDataDisplayManagerDelegate> delegate;

- (void)configureDataDisplayManagerWithEvents:(NSArray *)events;
- (void)updateTableViewModelWithEvents:(NSArray *)events;

@end
