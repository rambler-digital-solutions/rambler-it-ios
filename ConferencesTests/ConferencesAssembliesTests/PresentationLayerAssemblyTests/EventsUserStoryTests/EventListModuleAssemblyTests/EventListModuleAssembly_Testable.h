//
//  EventListModuleAssembly_Testable.h
//  Conferences
//
//  Created by Karpushin Artem on 15/11/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "EventListModuleAssembly.h"

@class EventListTableViewController;
@class EventListInteractor;
@class EventListPresenter;
@class EventListRouter;
@class EventListDataDisplayManager;

@interface EventListModuleAssembly ()

- (EventListTableViewController *)viewEventList;
- (EventListInteractor *)interactorEventList;
- (EventListPresenter *)presenterEventList;
- (EventListRouter *)routerEventList;
- (EventListDataDisplayManager *)dataDisplayManagerEventList;

@end
