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

#import "EventModuleAssembly.h"
#import "EventViewController.h"
#import "EventInteractor.h"
#import "EventPresenter.h"
#import "EventRouter.h"
#import "EventDataDisplayManager.h"
#import "EventPresenterStateStorage.h"
#import "ServiceComponents.h"
#import "PresentationLayerHelpersAssembly.h"
#import "EventCellObjectBuilderFactory.h"

@interface EventModuleAssembly ()

@property (strong, nonatomic, readonly) EventCellObjectBuilderFactory *eventCellObjectBuilderFactory;

@end

@implementation  EventModuleAssembly

- (EventViewController *)viewEvent {
    return [TyphoonDefinition withClass:[EventViewController class]
                            configuration:^(TyphoonDefinition *definition) {
                                [definition injectProperty:@selector(output)
                                                      with:[self presenterEvent]];
                                [definition injectProperty:@selector(dataDisplayManager)
                                                      with:[self dataDisplayManagerEvent]];
             }];
}

- (EventInteractor *)interactorEvent {
    return [TyphoonDefinition withClass:[EventInteractor class]
                            configuration:^(TyphoonDefinition *definition) {
                                [definition injectProperty:@selector(output)
                                                      with:[self presenterEvent]];
                                [definition injectProperty:@selector(eventService)
                                                      with:[self.serviceComponents eventService]];
                                [definition injectProperty:@selector(eventPrototypeMapper)
                                                      with:[self.serviceComponents eventPrototypeMapper]];
                                [definition injectProperty:@selector(eventTypeDeterminator)
                                                      with:[self.presentationLayerHelpersAssembly eventTypeDeterminator]];
             }];
}

- (EventPresenter *)presenterEvent {
    return [TyphoonDefinition withClass:[EventPresenter class]
                            configuration:^(TyphoonDefinition *definition) {
                                [definition injectProperty:@selector(view)
                                                      with:[self viewEvent]];
                                [definition injectProperty:@selector(interactor)
                                                      with:[self interactorEvent]];
                                [definition injectProperty:@selector(router)
                                                      with:[self routerEvent]];
                                [definition injectProperty:@selector(presenterStateStorage)
                                                      with:[self presenterStateStorage]];
            }];
}

- (EventRouter *)routerEvent {
    return [TyphoonDefinition withClass:[EventRouter class]
                            configuration:^(TyphoonDefinition *definition) {

           }];
}

- (EventDataDisplayManager *)dataDisplayManagerEvent {
    return [TyphoonDefinition withClass:[EventDataDisplayManager class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(cellObjectBuilderFactory)
                                                    with:self.eventCellObjectBuilderFactory];
    }];
}

- (EventPresenterStateStorage *)presenterStateStorage {
    return [TyphoonDefinition withClass:[EventPresenterStateStorage class]];
}

@end