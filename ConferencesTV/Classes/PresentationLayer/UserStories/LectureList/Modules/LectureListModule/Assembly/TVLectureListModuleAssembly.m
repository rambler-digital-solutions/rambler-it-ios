//
//  TVLectureListModuleTVLectureListModuleAssembly.m
//  Conferences
//
//  Created by Porokhov Artem on 21/12/2016.
//  Copyright © 2016 Rambler&Co. All rights reserved.
//

#import "TVLectureListModuleAssembly.h"

#import "TVLectureListModuleViewController.h"
#import "TVLectureListModuleInteractor.h"
#import "TVLectureListModulePresenter.h"
#import "TVLectureListModuleRouter.h"

#import <ViperMcFlurry/ViperMcFlurry.h>

@implementation TVLectureListModuleAssembly

- (TVLectureListModuleViewController *)viewEventListModuleModule {
    return [TyphoonDefinition withClass:[TVLectureListModuleViewController class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(output)
                                                    with:[self presenterEventListModuleModule]];
                              [definition injectProperty:@selector(moduleInput)
                                                    with:[self presenterEventListModuleModule]];
                          }];
}

- (TVLectureListModuleInteractor *)interactorEventListModuleModule {
    return [TyphoonDefinition withClass:[TVLectureListModuleInteractor class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(output)
                                                    with:[self presenterEventListModuleModule]];
                          }];
}

- (TVLectureListModulePresenter *)presenterEventListModuleModule {
    return [TyphoonDefinition withClass:[TVLectureListModulePresenter class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(view)
                                                    with:[self viewEventListModuleModule]];
                              [definition injectProperty:@selector(interactor)
                                                    with:[self interactorEventListModuleModule]];
                              [definition injectProperty:@selector(router)
                                                    with:[self routerEventListModuleModule]];
                          }];
}

- (TVLectureListModuleRouter *)routerEventListModuleModule {
    return [TyphoonDefinition withClass:[TVLectureListModuleRouter class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(transitionHandler)
                                                    with:[self viewEventListModuleModule]];
                          }];
}

@end
