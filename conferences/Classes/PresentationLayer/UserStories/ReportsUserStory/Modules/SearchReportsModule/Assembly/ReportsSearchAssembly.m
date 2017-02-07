// Copyright (c) 2015 RAMBLER&Co
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "ReportsSearchAssembly.h"
#import "ReportsSearchInteractor.h"
#import "ReportsSearchPresenter.h"
#import "ReportsSearchViewController.h"
#import "ReportsSearchRouter.h"
#import "ReportsSearchCellObjectsBuilderImplementation.h"
#import "ReportsSearchCellObjectsDirectorImplementation.h"
#import "PredicateConfiguratorImplementation.h"
#import "SearchFacadeImplementation.h"
#import "ServiceComponents.h"
#import "PresentationLayerHelpersAssembly.h"

#import <Typhoon/Typhoon.h>

@implementation ReportsSearchAssembly

- (ReportsSearchViewController *)viewReportsSearch {
    return [TyphoonDefinition withClass:[ReportsSearchViewController class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(output)
                                                    with:[self presenterReportsSearch]];
                              [definition injectProperty:@selector(dataDisplayManager)
                                                    with:[self dataDisplayManagerReportsSearch]];
                              [definition injectProperty:@selector(feedbackGenerator)
                                                    with:[self.presentationLayerHelpersAssembly generalFeedbackGenerator]];
                          }];
}

- (ReportsSearchInteractor *)interactorReportsSearch {
    return [TyphoonDefinition withClass:[ReportsSearchInteractor class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(output)
                                                    with:[self presenterReportsSearch]];
                              [definition injectProperty:@selector(searchFacade)
                                                    with:[self searchFacade]];
                              [definition injectProperty:@selector(predicateConfigurator)
                                                    with:[self predicateConfigurator]];
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
                              [definition useInitializer:@selector(initWithCellObjectDirector:) parameters:^(TyphoonMethod *initializer) {
                                  [initializer injectParameterWith:[self cellObjectsDirector]];
                              }];
                          }];
}

- (ReportsSearchCellObjectsDirectorImplementation *)cellObjectsDirector {
    return [TyphoonDefinition withClass:[ReportsSearchCellObjectsDirectorImplementation class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition useInitializer:@selector(initWithBuilder:) parameters:^(TyphoonMethod *initializer) {
                                  [initializer injectParameterWith:[self cellObjectsBuilder]];
                              }];
                          }];
}

- (ReportsSearchCellObjectsBuilderImplementation *)cellObjectsBuilder {
    return [TyphoonDefinition withClass:[ReportsSearchCellObjectsBuilderImplementation class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition useInitializer:@selector(initWithDateFormatter:) parameters:^(TyphoonMethod *initializer) {
                                  [initializer injectParameterWith:[self.presentationLayerHelpersAssembly dateFormatter]];
                              }];
                          }];
}

- (PredicateConfiguratorImplementation *)predicateConfigurator {
    return [TyphoonDefinition withClass:[PredicateConfiguratorImplementation class]];
}

- (SearchFacadeImplementation *)searchFacade {
    return [TyphoonDefinition withClass:[SearchFacadeImplementation class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(eventService)
                                                    with:[self.serviceComponents eventService]];
                              [definition injectProperty:@selector(speakerService)
                                                    with:[self.serviceComponents speakerService]];
                              [definition injectProperty:@selector(lectureService)
                                                    with:[self.serviceComponents lectureService]];
                              [definition injectProperty:@selector(ponsomizer)
                                                    with:[self.ponsomizerAssembly ponsomizer]];
                          }];
}

@end
