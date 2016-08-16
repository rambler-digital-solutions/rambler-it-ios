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

#import "EventGalleryAssembly.h"

#import "ServiceComponents.h"
#import "PonsomizerAssembly.h"
#import "PresentationLayerHelpersAssembly.h"

#import "EventGalleryViewController.h"
#import "EventGalleryInteractor.h"
#import "EventGalleryPresenter.h"
#import "EventGalleryRouter.h"
#import "FutureEventFilter.h"
#import "EventGalleryDataDisplayManager.h"
#import "EventGalleryCellObjectFactory.h"
#import "EventGalleryPageSizeCalculator.h"
#import "EventGalleryBackgroundColorAnimator.h"
#import "EventGalleryCollectionViewFlowLayout.h"

#import <ViperMcFlurry/ViperMcFlurry.h>

@implementation EventGalleryAssembly

- (EventGalleryViewController *)viewEventGalleryModule {
    return [TyphoonDefinition withClass:[EventGalleryViewController class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(output)
                                                    with:[self presenterEventGalleryModule]];
                              [definition injectProperty:@selector(moduleInput)
                                                    with:[self presenterEventGalleryModule]];
                              [definition injectProperty:@selector(dataDisplayManager)
                                                    with:[self dataDisplayManagerEventGalleryModule]];
                              [definition injectProperty:@selector(backgroundColorAnimator)
                                                    with:[self eventGalleryBackgroundColorAnimator]];
                              [definition injectProperty:@selector(collectionViewFlowLayout)
                                                    with:[self flowLayoutEventGalleryModule]];
                          }];
}

- (EventGalleryInteractor *)interactorEventGalleryModule {
    return [TyphoonDefinition withClass:[EventGalleryInteractor class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(output)
                                                    with:[self presenterEventGalleryModule]];
                              [definition injectProperty:@selector(eventService)
                                                    with:[self.serviceComponents eventService]];
                              [definition injectProperty:@selector(ponsomizer)
                                                    with:[self.ponsomizerAssembly ponsomizer]];
                              [definition injectProperty:@selector(futureEventFilter)
                                                    with:[self futureEventFilter]];
                          }];
}

- (EventGalleryPresenter *)presenterEventGalleryModule {
    return [TyphoonDefinition withClass:[EventGalleryPresenter class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(view)
                                                    with:[self viewEventGalleryModule]];
                              [definition injectProperty:@selector(interactor)
                                                    with:[self interactorEventGalleryModule]];
                              [definition injectProperty:@selector(router)
                                                    with:[self routerEventGalleryModule]];
                          }];
}

- (EventGalleryRouter *)routerEventGalleryModule {
    return [TyphoonDefinition withClass:[EventGalleryRouter class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(transitionHandler)
                                                    with:[self viewEventGalleryModule]];
                          }];
}

- (FutureEventFilter *)futureEventFilter {
    return [TyphoonDefinition withClass:[FutureEventFilter class]];
}

- (EventGalleryDataDisplayManager *)dataDisplayManagerEventGalleryModule {
    return [TyphoonDefinition withClass:[EventGalleryDataDisplayManager class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition useInitializer:@selector(initWithCellObjectFactory:animator:delegate:)
                                              parameters:^(TyphoonMethod *initializer) {
                                                  [initializer injectParameterWith:[self cellObjectFactoryEventGalleryModule]];
                                                  [initializer injectParameterWith:[self eventGalleryBackgroundColorAnimator]];
                                                  [initializer injectParameterWith:[self viewEventGalleryModule]];
                                              }];
                          }];
}

- (EventGalleryCellObjectFactory *)cellObjectFactoryEventGalleryModule {
    return [TyphoonDefinition withClass:[EventGalleryCellObjectFactory class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(dateFormatter)
                                                    with:[self.presentationLayerHelpersAssembly dateFormatter]];
                          }];
}

- (EventGalleryCollectionViewFlowLayout *)flowLayoutEventGalleryModule {
    return [TyphoonDefinition withClass:[EventGalleryCollectionViewFlowLayout class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(calculator)
                                                    with:[self eventGalleryPageSizeCalculator]];
                          }];
}

- (EventGalleryBackgroundColorAnimator *)eventGalleryBackgroundColorAnimator {
    return [TyphoonDefinition withClass:[EventGalleryBackgroundColorAnimator class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(dataSource)
                                                    with:[self dataDisplayManagerEventGalleryModule]];
                              [definition injectProperty:@selector(calculator)
                                                    with:[self eventGalleryPageSizeCalculator]];
                          }];
}

- (EventGalleryPageSizeCalculator *)eventGalleryPageSizeCalculator {
    return [TyphoonDefinition withClass:[EventGalleryPageSizeCalculator class]];
}

@end
