//
//  SpeakerInfoPresenter.m
//  Conferences
//
//  Created by Karpushin Artem on 16/01/16.
//  Copyright 2016 Rambler. All rights reserved.
//

#import "SpeakerInfoPresenter.h"
#import "SpeakerInfoViewInput.h"
#import "SpeakerInfoInteractorInput.h"
#import "SpeakerInfoRouterInput.h"
#import "SpeakerInfoPresenterStateStorage.h"

@implementation SpeakerInfoPresenter

#pragma mark - SpeakerInfoViewOutput

- (void)setupView {
    SpeakerPlainObject *speaker = [self.interactor obtainSpeakerWithSpeakerId:self.stateStorage.speakerId];
    [self.view setupViewWithSpeaker:speaker];
}

#pragma mark - SpeakerInfoInteractorOutput

#pragma mark - SpeakerInfoModuleInput

- (void)configureCurrentModuleWithSpeakerId:(NSString *)speakerId {
    self.stateStorage.speakerId = speakerId;
}

@end