//
//  SpeakerInfoModuleAssembly.m
//  Conferences
//
//  Created by Karpushin Artem on 16/01/16.
//  Copyright 2016 Rambler. All rights reserved.
//

#import "SpeakerInfoModuleAssembly.h"
#import "SpeakerInfoViewController.h"
#import "SpeakerInfoInteractor.h"
#import "SpeakerInfoPresenter.h"
#import "SpeakerInfoRouter.h"
#import "SpeakerInfoPresenterStateStorage.h"

@implementation  SpeakerInfoModuleAssembly

- (SpeakerInfoViewController *)viewSpeakerInfo {
    return [TyphoonDefinition withClass:[SpeakerInfoViewController class]
                            configuration:^(TyphoonDefinition *definition) {
                                [definition injectProperty:@selector(output)
                                                      with:[self presenterSpeakerInfo]];
             }];
}

- (SpeakerInfoInteractor *)interactorSpeakerInfo {
    return [TyphoonDefinition withClass:[SpeakerInfoInteractor class]
                            configuration:^(TyphoonDefinition *definition) {
                                [definition injectProperty:@selector(output)
                                                      with:[self presenterSpeakerInfo]];
             }];
}

- (SpeakerInfoPresenter *)presenterSpeakerInfo {
    return [TyphoonDefinition withClass:[SpeakerInfoPresenter class]
                            configuration:^(TyphoonDefinition *definition) {
                                [definition injectProperty:@selector(view)
                                                      with:[self viewSpeakerInfo]];
                                [definition injectProperty:@selector(interactor)
                                                      with:[self interactorSpeakerInfo]];
                                [definition injectProperty:@selector(router)
                                                      with:[self routerSpeakerInfo]];
                                [definition injectProperty:@selector(stateStorage)
                                                      with:[self presenterStateStorageSpeakerInfo]];
            }];
}

- (SpeakerInfoRouter *)routerSpeakerInfo {
    return [TyphoonDefinition withClass:[SpeakerInfoRouter class]
                            configuration:^(TyphoonDefinition *definition) {
           }];
}

- (SpeakerInfoPresenterStateStorage *)presenterStateStorageSpeakerInfo {
    return [TyphoonDefinition withClass:[SpeakerInfoPresenterStateStorage class]];
}

@end