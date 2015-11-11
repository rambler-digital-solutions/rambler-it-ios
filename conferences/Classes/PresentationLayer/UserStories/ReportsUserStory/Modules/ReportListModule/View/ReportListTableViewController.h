//
//  ReportListView.h
//  Conferences
//
//  Created by Karpushin Artem on 08/11/15.
//  Copyright 2015 Rambler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReportListViewInput.h"

@protocol ReportListViewOutput;
@class  ReportListDataDisplayManager;

@interface ReportListTableViewController : UITableViewController <ReportListViewInput>

@property (nonatomic, strong) id<ReportListViewOutput> output;
@property (strong, nonatomic) ReportListDataDisplayManager *dataDisplayManager;

@end

