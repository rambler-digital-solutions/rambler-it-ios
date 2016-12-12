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

#import "MessageExtensionAssembly.h"
#import "MessagesViewController.h"
#import "EventListModuleAssembly.h"
#import "PonsomizerAssembly.h"
#import "ServiceComponents.h"
#import "MessagesLaunchHandler.h"
#import "SpotlightIndexerAssembly.h"
#import "MessagesRouter.h"
#import "MessagesPresenter.h"
#import "MessagesInteractor.h"
#import "UrlComponentsFactory.h"

@implementation MessageExtensionAssembly

- (MessagesViewController *)messageExtension {
    return [TyphoonDefinition withClass:[MessagesViewController class]
                          configuration:^(TyphoonDefinition *definition) {
        [definition injectProperty:@selector(dataDisplayManager)
                            with:[self.eventListAssembly dataDisplayManagerEventList]];
        [definition injectProperty:@selector(output)
                              with:[self messagesPresenter]];
        [definition injectProperty:@selector(currentConversation)
                              with:[self conversation]];
        }];
}

- (MessagesPresenter *)messagesPresenter {
    return [TyphoonDefinition withClass:[MessagesPresenter class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(view)
                                                    with:[self messageExtension]];
                              [definition injectProperty:@selector(interactor)
                                                    with:[self messagesInteractor]];
                              [definition injectProperty:@selector(router)
                                                    with:[self messagesRouter]];
                          }];
}

- (MessagesInteractor *)messagesInteractor {
    return [TyphoonDefinition withClass:[MessagesInteractor class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(output)
                                                    with:[self messagesPresenter]];
                              [definition injectProperty:@selector(eventService)
                                                    with:[self.serviceComponents eventService]];
                              [definition injectProperty:@selector(ponsomizer)
                                                    with:[self.ponsomizerAssembly ponsomizer]];
                              [definition injectProperty:@selector(transformer)
                                                    with:[self.spotlightIndexerAssembly eventObjectTransformer]];
                              [definition injectProperty:@selector(eventListProcessor)
                                                    with:[self.eventListAssembly eventListProcessor]];
                          }];
}

- (id<MessagesRouterInput>)messagesRouter {
    return [TyphoonDefinition withClass:[MessagesRouter class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(helper)
                                                    with:[self urlComponentsHelper]];
    }];
}

- (MSConversation *)conversation {
    return [TyphoonDefinition withClass:[MSConversation class]];
}

- (UrlComponentsFactory *)urlComponentsHelper {
    return [TyphoonDefinition withClass:[UrlComponentsFactory class]];
}

@end
