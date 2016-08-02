//
//  ReportListModuleAssembly_Testable.h
//  Conferences
//
//  Created by Karpushin Artem on 22/11/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "ReportListModuleAssembly.h"

@class ReportListViewController;
@class ReportListInteractor;
@class ReportListPresenter;
@class ReportListRouter;
@class ReportListDataDisplayManager;

@interface ReportListModuleAssembly ()

- (ReportListViewController *)viewReportList;
- (ReportListInteractor *)interactorReportList;
- (ReportListPresenter *)presenterReportList;
- (ReportListRouter *)routerReportList;
- (ReportListDataDisplayManager *)dataDisplayManagerReportList;

@end
