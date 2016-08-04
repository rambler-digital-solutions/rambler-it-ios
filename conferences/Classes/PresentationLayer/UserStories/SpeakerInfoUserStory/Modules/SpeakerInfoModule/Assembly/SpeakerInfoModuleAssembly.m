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
#import "SpeakerInfoDataDisplayManager.h"
#import "SpeakerInfoCellObjectsBuilder.h"
#import "SocialContactsConfigurator.h"
#import "ServiceComponents.h"
#import "PonsomizerAssembly.h"

@implementation  SpeakerInfoModuleAssembly

- (SpeakerInfoViewController *)viewSpeakerInfo {
    return [TyphoonDefinition withClass:[SpeakerInfoViewController class]
                            configuration:^(TyphoonDefinition *definition) {
                                [definition injectProperty:@selector(output)
                                                      with:[self presenterSpeakerInfo]];
                                [definition injectProperty:@selector(dataDisplayManager)
                                                      with:[self dataDisplayManagerSpeakerInfo]];
             }];
}

- (SpeakerInfoInteractor *)interactorSpeakerInfo {
    return [TyphoonDefinition withClass:[SpeakerInfoInteractor class]
                            configuration:^(TyphoonDefinition *definition) {
                                [definition injectProperty:@selector(output)
                                                      with:[self presenterSpeakerInfo]];
                                [definition injectProperty:@selector(speakerService)
                                                      with:[self.serviceComponents speakerService]];
                                [definition injectProperty:@selector(ponsomizer)
                                                      with:[self.ponsomizerAssembly ponsomizer]];
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

- (SpeakerInfoDataDisplayManager *)dataDisplayManagerSpeakerInfo {
    return [TyphoonDefinition withClass:[SpeakerInfoDataDisplayManager class] configuration:^(TyphoonDefinition *definition) {
        [definition injectProperty:@selector(cellObjectBuilder)
                              with:[self cellObjectsBuilderSpeakerInfo]];
    }];
}

- (SpeakerInfoCellObjectsBuilder *)cellObjectsBuilderSpeakerInfo {
    return [TyphoonDefinition withClass:[SpeakerInfoCellObjectsBuilder class]
                          configuration:^(TyphoonDefinition *definition) {
        [definition injectProperty:@selector(configurator)
                              with:[self socialContactsConfiguratorSpeakerInfo]];
    }];
}

- (SocialContactsConfigurator *)socialContactsConfiguratorSpeakerInfo {
    return [TyphoonDefinition withClass:[SocialContactsConfigurator class]];
}

@end