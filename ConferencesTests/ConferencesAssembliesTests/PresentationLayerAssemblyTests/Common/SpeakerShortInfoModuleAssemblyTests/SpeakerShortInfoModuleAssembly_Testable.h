//
//  SpeakerShortInfoModuleAssembly_Testable.h
//  Conferences
//
//  Created by Karpushin Artem on 26/03/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import "SpeakerShortInfoModuleAssembly.h"

@class SpeakerShortInfoInteractor;
@class SpeakerShortInfoView;
@class SpeakerShortInfoPresenter;
@class SpeakerShortInfoRouter;

@interface SpeakerShortInfoModuleAssembly ()

- (SpeakerShortInfoView *)viewSpeakerShortInfo;
- (SpeakerShortInfoInteractor *)interactorSpeakerShortInfo;
- (SpeakerShortInfoPresenter *)presenterSpeakerShortInfo;
- (SpeakerShortInfoRouter *)routerSpeakerShortInfo;

@end
