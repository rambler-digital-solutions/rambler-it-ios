//
//  ReportsSearchDisplayController.h
//  Conferences
//
//  Created by k.zinovyev on 16.07.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReportsSearchViewOutput.h"
#import "ReportsSearchViewInput.h"
#import "ReportsSearchDataDisplayManager.h"

@interface ReportsSearchViewController : UIViewController <ReportsSearchViewInput, ReportSearchDataDisplayManagerDelegate>

@property (nonatomic, strong) id<ReportsSearchViewOutput> output;
@property (strong, nonatomic) ReportsSearchDataDisplayManager *dataDisplayManager;

@end
