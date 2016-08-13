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

#import "SpeakerInfoModuleAssembly.h"

#import "SpeakerInfoViewController.h"
#import "SpeakerInfoInteractor.h"
#import "SpeakerInfoPresenter.h"
#import "SpeakerInfoRouter.h"
#import "SpeakerInfoPresenterStateStorage.h"
#import "SpeakerInfoDataDisplayManager.h"
#import "SpeakerInfoCellObjectBuilder.h"
#import "SocialContactsConfigurator.h"
#import "ServiceComponents.h"
#import "PonsomizerAssembly.h"
#import "PresentationLayerHelpersAssembly.h"

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
                                [definition injectProperty:@selector(transitionHandler)
                                                      with:[self viewSpeakerInfo]];
                                [definition injectProperty:@selector(safariFactory)
                                                      with:[self.presentationLayerHelpersAssembly safariFactory]];
           }];
}

- (SpeakerInfoPresenterStateStorage *)presenterStateStorageSpeakerInfo {
    return [TyphoonDefinition withClass:[SpeakerInfoPresenterStateStorage class]];
}

- (SpeakerInfoDataDisplayManager *)dataDisplayManagerSpeakerInfo {
    return [TyphoonDefinition withClass:[SpeakerInfoDataDisplayManager class] configuration:^(TyphoonDefinition *definition) {
        [definition injectProperty:@selector(cellObjectBuilder)
                              with:[self cellObjectsBuilderSpeakerInfo]];
        [definition injectProperty:@selector(delegate)
                              with:[self viewSpeakerInfo]];
    }];
}

- (SpeakerInfoCellObjectBuilder *)cellObjectsBuilderSpeakerInfo {
    return [TyphoonDefinition withClass:[SpeakerInfoCellObjectBuilder class]
                          configuration:^(TyphoonDefinition *definition) {
        [definition injectProperty:@selector(configurator)
                              with:[self socialContactsConfiguratorSpeakerInfo]];
    }];
}

- (SocialContactsConfigurator *)socialContactsConfiguratorSpeakerInfo {
    return [TyphoonDefinition withClass:[SocialContactsConfigurator class]];
}

@end