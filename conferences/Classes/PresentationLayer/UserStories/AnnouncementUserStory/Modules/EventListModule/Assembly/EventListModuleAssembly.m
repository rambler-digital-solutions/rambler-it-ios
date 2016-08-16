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

#import "EventListModuleAssembly.h"
#import "EventListTableViewController.h"
#import "EventListInteractor.h"
#import "EventListPresenter.h"
#import "EventListRouter.h"
#import "EventListDataDisplayManager.h"
#import "ServiceComponents.h"
#import "PresentationLayerHelpersAssembly.h"
#import "PonsomizerAssembly.h"
#import "EventListCellObjectBuilder.h"
#import "UIView+LJLoadFromNib.h"

@implementation EventListModuleAssembly

- (EventListTableViewController *)viewEventList {
    return [TyphoonDefinition withClass:[EventListTableViewController class]
                          configuration:^(TyphoonDefinition *definition) {
                            [definition injectProperty:@selector(output) 
                                                  with:[self presenterEventList]];
                              [definition injectProperty:@selector(dataDisplayManager)
                                                    with:[self dataDisplayManagerEventList]];
                              [definition injectProperty:@selector(dateFormatter)
                                                    with:[self.presentationLayerHelpersAssembly dateFormatter]];
             }];
}

- (EventListInteractor *)interactorEventList {
    return [TyphoonDefinition withClass:[EventListInteractor class]
                            configuration:^(TyphoonDefinition *definition) {
                                [definition injectProperty:@selector(output)
                                                        with:[self presenterEventList]];
                                [definition injectProperty:@selector(eventService)
                                                    with:[self.serviceComponents eventService]];
                                [definition injectProperty:@selector(ponsomizer)
                                                      with:[self.coreAssembly ponsomizer]];
             }];
}

- (EventListPresenter *)presenterEventList {
    return [TyphoonDefinition withClass:[EventListPresenter class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(view)
                                                    with:[self viewEventList]];
                              [definition injectProperty:@selector(interactor)
                                                    with:[self interactorEventList]];
                              [definition injectProperty:@selector(router)
                                                    with:[self routerEventList]];
            }];
}

- (EventListRouter *)routerEventList {
    return [TyphoonDefinition withClass:[EventListRouter class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(transitionHandler)
                                                    with:[self viewEventList]];
           }];
}

- (EventListDataDisplayManager *)dataDisplayManagerEventList {
    return [TyphoonDefinition withClass:[EventListDataDisplayManager class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(cellObjectBuilder)
                                                    with:[self cellObjectBuilderEventList]];
                          }];
}

- (EventListCellObjectBuilder *)cellObjectBuilderEventList {
    return [TyphoonDefinition withClass:[EventListCellObjectBuilder class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(dateFormatter)
                                                    with:[self.presentationLayerHelpersAssembly dateFormatter]];
                          }];
}

@end