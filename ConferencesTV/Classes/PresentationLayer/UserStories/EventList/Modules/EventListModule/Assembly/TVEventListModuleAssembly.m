//
//  TVEventListModuleTVEventListModuleAssembly.m
//  Conferences
//
//  Created by Porokhov Artem on 21/12/2016.
//  Copyright © 2016 Rambler&Co. All rights reserved.
//

#import "TVEventListModuleAssembly.h"

#import "TVEventListModuleViewController.h"
#import "TVEventListModuleInteractor.h"
#import "TVEventListModulePresenter.h"
#import "TVEventListModuleRouter.h"

#import <ViperMcFlurry/ViperMcFlurry.h>

@implementation TVEventListModuleAssembly

- (TVEventListModuleViewController *)viewEventListModuleModule {
    return [TyphoonDefinition withClass:[TVEventListModuleViewController class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(output)
                                                    with:[self presenterEventListModuleModule]];
                              [definition injectProperty:@selector(moduleInput)
                                                    with:[self presenterEventListModuleModule]];
                          }];
}

- (TVEventListModuleInteractor *)interactorEventListModuleModule {
    return [TyphoonDefinition withClass:[TVEventListModuleInteractor class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(output)
                                                    with:[self presenterEventListModuleModule]];
                          }];
}

- (TVEventListModulePresenter *)presenterEventListModuleModule {
    return [TyphoonDefinition withClass:[TVEventListModulePresenter class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(view)
                                                    with:[self viewEventListModuleModule]];
                              [definition injectProperty:@selector(interactor)
                                                    with:[self interactorEventListModuleModule]];
                              [definition injectProperty:@selector(router)
                                                    with:[self routerEventListModuleModule]];
                          }];
}

- (TVEventListModuleRouter *)routerEventListModuleModule {
    return [TyphoonDefinition withClass:[TVEventListModuleRouter class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(transitionHandler)
                                                    with:[self viewEventListModuleModule]];
                          }];
}

@end
