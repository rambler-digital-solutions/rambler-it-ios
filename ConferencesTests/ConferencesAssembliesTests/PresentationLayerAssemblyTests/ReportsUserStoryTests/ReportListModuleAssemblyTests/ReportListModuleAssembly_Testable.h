//
//  ReportListModuleAssembly_Testable.h
//  Conferences
//
//  Created by Karpushin Artem on 22/11/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "ReportListModuleAssembly.h"

@class ReportListTableViewController;
@class ReportListInteractor;
@class ReportListPresenter;
@class ReportListRouter;
@class ReportListDataDisplayManager;
@class UIStoryboard;
@protocol TabBarControllerContent;

@interface ReportListModuleAssembly ()

- (ReportListTableViewController *)viewReportList;
- (ReportListInteractor *)interactorReportList;
- (ReportListPresenter *)presenterReportList;
- (ReportListRouter *)routerReportList;
- (ReportListDataDisplayManager *)dataDisplayManagerReportList;
- (id<TabBarControllerContent>)reportListTabBarControllerContent;
- (UIStoryboard*)reportListStoryboard;

@end
