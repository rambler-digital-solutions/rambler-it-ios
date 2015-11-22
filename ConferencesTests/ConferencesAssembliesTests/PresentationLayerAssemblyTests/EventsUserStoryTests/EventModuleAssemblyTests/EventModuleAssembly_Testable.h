//
//  EventModuleAssembly_Testable.h
//  Conferences
//
//  Created by Karpushin Artem on 15/11/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "EventModuleAssembly.h"

@class EventViewController;
@class EventInteractor;
@class EventPresenter;
@class EventRouter;
@class EventDataDisplayManager;
@class EventPresenterStateStorage;

@interface EventModuleAssembly ()

- (EventViewController *)viewEvent;
- (EventInteractor *)interactorEvent;
- (EventPresenter *)presenterEvent;
- (EventRouter *)routerEvent;
- (EventDataDisplayManager *)dataDisplayManagerEvent;
- (EventPresenterStateStorage *)presenterStateStorage;

@end
