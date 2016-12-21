//
//  TVEventListModuleTVEventListModuleAssembly_Testable.h
//  Conferences
//
//  Created by Porokhov Artem on 21/12/2016.
//  Copyright © 2016 Rambler&Co. All rights reserved.
//

#import "TVEventListModuleAssembly.h"

@class TVEventListModuleViewController;
@class TVEventListModuleInteractor;
@class TVEventListModulePresenter;
@class TVEventListModuleRouter;

@interface TVEventListModuleAssembly ()

- (TVEventListModuleViewController *)viewEventListModuleModule;
- (TVEventListModulePresenter *)presenterEventListModuleModule;
- (TVEventListModuleInteractor *)interactorEventListModuleModule;
- (TVEventListModuleRouter *)routerEventListModuleModule;

@end
