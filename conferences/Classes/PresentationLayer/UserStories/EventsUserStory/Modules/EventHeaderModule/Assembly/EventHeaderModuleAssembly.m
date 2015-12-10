//
//  EventHeaderModuleAssembly.m
//  Conferences
//
//  Created by Karpushin Artem on 10/12/15.
//  Copyright 2015 Rambler. All rights reserved.
//

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