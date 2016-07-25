//
//  ReportSearchAssembly.m
//  Conferences
//
//  Created by k.zinovyev on 16.07.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import "ReportsSearchAssembly.h"
#import "ReportsSearchInteractor.h"
#import "ReportsSearchPresenter.h"
#import "ReportsSearchViewController.h"
#import "ReportsSearchRouter.h"

#import <Typhoon/Typhoon.h>
#import "ServiceComponents.h"
#import "PresentationLayerHelpersAssembly.h"

@implementation ReportsSearchAssembly

- (ReportsSearchViewController *)viewReportsSearch {
    return [TyphoonDefinition withClass:[ReportsSearchViewController class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(output)
                                                    with:[self presenterReportsSearch]];
                              [definition injectProperty:@selector(dataDisplayManager)
                                                    with:[self dataDisplayManagerReportsSearch]];
                          }];
}

- (ReportsSearchInteractor *)interactorReportsSearch {
    return [TyphoonDefinition withClass:[ReportsSearchInteractor class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(output)
                                                    with:[self presenterReportsSearch]];
                              [definition injectProperty:@selector(eventService)
                                                    with:[self.serviceComponents eventService]];
                              [definition injectProperty:@selector(speakerService)
                                                    with:[self.serviceComponents speakerService]];
                              [definition injectProperty:@selector(lectureService)
                                                    with:[self.serviceComponents lectureService]];
                              [definition injectProperty:@selector(ponsomizer)
                                                    with:[self.ponsomizerAssembly ponsomizer]];
                              [definition injectProperty:@selector(eventTypeDeterminator)
                                                    with:[self.presentationLayerHelpersAssembly eventTypeDeterminator]];
                          }];
}

- (ReportsSearchPresenter *)presenterReportsSearch {
    return [TyphoonDefinition withClass:[ReportsSearchPresenter class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(view)
                                                    with:[self viewReportsSearch]];
                              [definition injectProperty:@selector(interactor)
                                                    with:[self interactorReportsSearch]];
                              [definition injectProperty:@selector(router)
                                                    with:[self routerReportsSearch]];
                          }];
}

- (ReportsSearchRouter *)routerReportsSearch {
    return [TyphoonDefinition withClass:[ReportsSearchRouter class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(transitionHandler)
                                                    with:[self viewReportsSearch]];
                          }];
}

- (ReportsSearchDataDisplayManager *)dataDisplayManagerReportsSearch {
    return [TyphoonDefinition withClass:[ReportsSearchDataDisplayManager class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(dateFormatter)
                                                    with:[self.presentationLayerHelpersAssembly dateFormatter]];
                          }];
}


@end
