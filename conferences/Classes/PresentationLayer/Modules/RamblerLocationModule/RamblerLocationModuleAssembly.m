//
//  RamblerLocationModuleAssembly.m
//  Conferences
//
//  Created by Karpushin Artem on 12/10/15.
//  Copyright 2015 Rambler. All rights reserved.
//

#import "RamblerLocationModuleAssembly.h"
#import "RamblerLocationView.h"
#import "RamblerLocationInteractor.h"
#import "RamblerLocationPresenter.h"
#import "RamblerLocationRouter.h"

@interface  RamblerLocationModuleAssembly()
@end


/**
 *  Assembly модуля, который 1
 *
 *  
 */
@implementation  RamblerLocationModuleAssembly

- (RamblerLocationView *)viewRamblerLocation {

    return [TyphoonDefinition withClass:[RamblerLocationView class]
                          configuration:^(TyphoonDefinition *definition) {
                            [definition injectProperty:@selector(output) 
                                                  with:[self presenterRamblerLocation]];
             }];
}

- (RamblerLocationInteractor *)interactorRamblerLocation
{
    return [TyphoonDefinition withClass:[RamblerLocationInteractor class]
                          configuration:^(TyphoonDefinition *definition) {
                            [definition injectProperty:@selector(output) 
                                                  with:[self presenterRamblerLocation]];
             }];
}

- (RamblerLocationPresenter *)presenterRamblerLocation
{
    return [TyphoonDefinition withClass:[RamblerLocationPresenter class]
                          configuration:^(TyphoonDefinition *definition) {
                            [definition injectProperty:@selector(view) 
                                                  with:[self viewRamblerLocation]];                                            
                            [definition injectProperty:@selector(interactor) 
                                                  with:[self interactorRamblerLocation]];
                            [definition injectProperty:@selector(router) 
                                                  with:[self routerRamblerLocation]];
            }];
}

- (RamblerLocationRouter *)routerRamblerLocation {
    return [TyphoonDefinition withClass:[RamblerLocationRouter class]
                          configuration:^(TyphoonDefinition *definition) {

           }];
}

@end