//
//  EventHeaderModuleAssembly_Testable.h
//  Conferences
//
//  Created by Karpushin Artem on 26/03/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import "EventHeaderModuleAssembly.h"

@class EventHeaderView;
@class EventHeaderInteractor;
@class EventHeaderPresenter;
@class EventHeaderRouter;

@interface EventHeaderModuleAssembly ()

- (EventHeaderView *)viewEventHeader;
- (EventHeaderInteractor *)interactorEventHeader;
- (EventHeaderPresenter *)presenterEventHeader;
- (EventHeaderRouter *)routerEventHeader;

@end
