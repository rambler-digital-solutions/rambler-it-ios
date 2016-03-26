//
//  SpeakerInfoModuleAssembly_Testable.h
//  Conferences
//
//  Created by Karpushin Artem on 26/03/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import "SpeakerInfoModuleAssembly.h"

@class SpeakerInfoViewController;
@class SpeakerInfoInteractor;
@class SpeakerInfoPresenter;
@class SpeakerInfoRouter;
@class SpeakerInfoPresenterStateStorage;
@class SpeakerInfoDataDisplayManager;

@interface SpeakerInfoModuleAssembly ()

- (SpeakerInfoViewController *)viewSpeakerInfo;
- (SpeakerInfoInteractor *)interactorSpeakerInfo;
- (SpeakerInfoPresenter *)presenterSpeakerInfo;
- (SpeakerInfoRouter *)routerSpeakerInfo;
- (SpeakerInfoPresenterStateStorage *)presenterStateStorageSpeakerInfo;
- (SpeakerInfoDataDisplayManager *)dataDisplayManagerSpeakerInfo;

@end
