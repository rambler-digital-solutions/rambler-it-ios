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

#import "EventHeaderModuleAssembly.h"
#import "EventHeaderView.h"
#import "EventHeaderInteractor.h"
#import "EventHeaderPresenter.h"
#import "EventHeaderRouter.h"

@interface  EventHeaderModuleAssembly()
@end

@implementation  EventHeaderModuleAssembly

- (EventHeaderView *)viewEventHeader {
    return [TyphoonDefinition withClass:[EventHeaderView class]
                            configuration:^(TyphoonDefinition *definition) {
                                [definition useInitializer:@selector(eventHeaderView)];
                                [definition injectProperty:@selector(output)
                                                      with:[self presenterEventHeader]];
             }];
}

- (EventHeaderInteractor *)interactorEventHeader {
    return [TyphoonDefinition withClass:[EventHeaderInteractor class]
                            configuration:^(TyphoonDefinition *definition) {
                                [definition injectProperty:@selector(output)
                                                      with:[self presenterEventHeader]];
             }];
}

- (EventHeaderPresenter *)presenterEventHeader {
    return [TyphoonDefinition withClass:[EventHeaderPresenter class]
                            configuration:^(TyphoonDefinition *definition) {
                                [definition injectProperty:@selector(view)
                                                      with:[self viewEventHeader]];
                                [definition injectProperty:@selector(interactor)
                                                      with:[self interactorEventHeader]];
                                [definition injectProperty:@selector(router)
                                                      with:[self routerEventHeader]];
            }];
}

- (EventHeaderRouter *)routerEventHeader {
    return [TyphoonDefinition withClass:[EventHeaderRouter class]
                          configuration:^(TyphoonDefinition *definition) {

           }];
}

@end