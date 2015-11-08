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

@interface ReportListTableViewController : UITableViewController <ReportListViewInput>

@property (nonatomic, strong) id<ReportListViewOutput> output;

@end

