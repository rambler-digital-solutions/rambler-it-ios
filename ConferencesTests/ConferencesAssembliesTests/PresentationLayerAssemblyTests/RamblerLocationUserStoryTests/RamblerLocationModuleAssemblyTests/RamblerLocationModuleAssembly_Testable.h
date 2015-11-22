//
//  RamblerLocationModuleAssembly_Testable.h
//  Conferences
//
//  Created by Karpushin Artem on 22/11/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "RamblerLocationModuleAssembly.h"

@class RamblerLocationViewController;
@class RamblerLocationInteractor;
@class RamblerLocationPresenter;
@class RamblerLocationRouter;

@interface RamblerLocationModuleAssembly ()

- (RamblerLocationViewController *)viewRamblerLocation;
- (RamblerLocationInteractor *)interactorRamblerLocation;
- (RamblerLocationPresenter *)presenterRamblerLocation;
- (RamblerLocationRouter *)routerRamblerLocation;

@end
