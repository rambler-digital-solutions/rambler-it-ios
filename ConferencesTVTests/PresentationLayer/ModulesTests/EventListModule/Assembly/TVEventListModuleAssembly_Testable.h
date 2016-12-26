//
//  TVLectureListModuleTVLectureListModuleAssembly_Testable.h
//  Conferences
//
//  Created by Porokhov Artem on 21/12/2016.
//  Copyright © 2016 Rambler&Co. All rights reserved.
//

#import "TVLectureListModuleAssembly.h"

@class TVLectureListModuleViewController;
@class TVLectureListModuleInteractor;
@class TVLectureListModulePresenter;
@class TVLectureListModuleRouter;

@interface TVLectureListModuleAssembly ()

- (TVLectureListModuleViewController *)viewEventListModuleModule;
- (TVLectureListModulePresenter *)presenterEventListModuleModule;
- (TVLectureListModuleInteractor *)interactorEventListModuleModule;
- (TVLectureListModuleRouter *)routerEventListModuleModule;

@end
