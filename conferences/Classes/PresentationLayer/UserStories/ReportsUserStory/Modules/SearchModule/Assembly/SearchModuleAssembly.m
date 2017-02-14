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

#import "SearchModuleAssembly.h"

#import "SearchViewController.h"
#import "SearchInteractor.h"
#import "SearchPresenter.h"
#import "SearchRouter.h"
#import "SearchDataDisplayManager.h"
#import "ServiceComponents.h"
#import "PresentationLayerHelpersAssembly.h"
#import "SearchCellObjectFactory.h"

@implementation  SearchModuleAssembly

- (SearchViewController *)viewSearchList {
    return [TyphoonDefinition withClass:[SearchViewController class]
                            configuration:^(TyphoonDefinition *definition) {
                                [definition injectProperty:@selector(output)
                                                      with:[self presenterSearchList]];
                                [definition injectProperty:@selector(dataDisplayManager)
                                                      with:[self dataDisplayManagerSearchList]];
             }];
}

- (SearchInteractor *)interactorSearchList {
    return [TyphoonDefinition withClass:[SearchInteractor class]
                            configuration:^(TyphoonDefinition *definition) {
                                [definition injectProperty:@selector(output)
                                                      with:[self presenterSearchList]];
                                [definition injectProperty:@selector(eventService)
                                                      with:[self.serviceComponents eventService]];
                                [definition injectProperty:@selector(suggestService)
                                                      with:[self.serviceComponents suggestService]];
                                [definition injectProperty:@selector(ponsomizer)
                                                      with:[self.ponsomizerAssembly ponsomizer]];
                                [definition injectProperty:@selector(eventTypeDeterminator)
                                                      with:[self.presentationLayerHelpersAssembly eventTypeDeterminator]];
             }];
}

- (SearchPresenter *)presenterSearchList {
    return [TyphoonDefinition withClass:[SearchPresenter class]
                            configuration:^(TyphoonDefinition *definition) {
                                [definition injectProperty:@selector(view)
                                                      with:[self viewSearchList]];
                                [definition injectProperty:@selector(interactor)
                                                      with:[self interactorSearchList]];
                                [definition injectProperty:@selector(router)
                                                      with:[self routerSearchList]];
            }];
}

- (SearchRouter *)routerSearchList {
    return [TyphoonDefinition withClass:[SearchRouter class]
                            configuration:^(TyphoonDefinition *definition) {
                                [definition injectProperty:@selector(transitionHandler)
                                                      with:[self viewSearchList]];
           }];
}

- (SearchDataDisplayManager *)dataDisplayManagerSearchList {
    return [TyphoonDefinition withClass:[SearchDataDisplayManager class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(dateFormatter)
                                                    with:[self.presentationLayerHelpersAssembly dateFormatter]];
                              [definition injectProperty:@selector(cellObjectFactory)
                                                    with:[self cellObjectFactorySearchList]];
    }];
}

- (SearchCellObjectFactory *)cellObjectFactorySearchList {
    return [TyphoonDefinition withClass:[SearchCellObjectFactory class]];
}

@end
