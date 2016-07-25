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

#import "ReportListModuleAssembly.h"
#import "ReportListViewController.h"
#import "ReportListInteractor.h"
#import "ReportListPresenter.h"
#import "ReportListRouter.h"
#import "ReportListDataDisplayManager.h"
#import "ServiceComponents.h"
#import "PresentationLayerHelpersAssembly.h"

@implementation  ReportListModuleAssembly

- (ReportListViewController *)viewReportList {
    return [TyphoonDefinition withClass:[ReportListViewController class]
                            configuration:^(TyphoonDefinition *definition) {
                                [definition injectProperty:@selector(output)
                                                      with:[self presenterReportList]];
                                [definition injectProperty:@selector(dataDisplayManager)
                                                      with:[self dataDisplayManagerReportList]];
             }];
}

- (ReportListInteractor *)interactorReportList {
    return [TyphoonDefinition withClass:[ReportListInteractor class]
                            configuration:^(TyphoonDefinition *definition) {
                                [definition injectProperty:@selector(output)
                                                      with:[self presenterReportList]];
                                [definition injectProperty:@selector(eventService)
                                                      with:[self.serviceComponents eventService]];
                                [definition injectProperty:@selector(ponsomizer)
                                                      with:[self.ponsomizerAssembly ponsomizer]];
                                [definition injectProperty:@selector(eventTypeDeterminator)
                                                      with:[self.presentationLayerHelpersAssembly eventTypeDeterminator]];
             }];
}

- (ReportListPresenter *)presenterReportList {
    return [TyphoonDefinition withClass:[ReportListPresenter class]
                            configuration:^(TyphoonDefinition *definition) {
                                [definition injectProperty:@selector(view)
                                                      with:[self viewReportList]];
                                [definition injectProperty:@selector(interactor)
                                                      with:[self interactorReportList]];
                                [definition injectProperty:@selector(router)
                                                      with:[self routerReportList]];
            }];
}

- (ReportListRouter *)routerReportList {
    return [TyphoonDefinition withClass:[ReportListRouter class]
                            configuration:^(TyphoonDefinition *definition) {
                                [definition injectProperty:@selector(transitionHandler)
                                                      with:[self viewReportList]];
           }];
}

- (ReportListDataDisplayManager *)dataDisplayManagerReportList {
    return [TyphoonDefinition withClass:[ReportListDataDisplayManager class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(dateFormatter)
                                                    with:[self.presentationLayerHelpersAssembly dateFormatter]];
    }];
}

@end