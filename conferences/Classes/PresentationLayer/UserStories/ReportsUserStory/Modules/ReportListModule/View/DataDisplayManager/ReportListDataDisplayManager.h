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

@protocol ReportListDataDisplayManagerDelegate

- (void)didUpdateTableViewModel;

@end

@interface ReportListDataDisplayManager : NSObject <DataDisplayManager>

@property (weak, nonatomic) id <ReportListDataDisplayManagerDelegate> delegate;

- (void)configureDataDisplayManagerWithEvents:(NSArray *)events;
- (void)updateTableViewModelWithEvents:(NSArray *)events;

@end
