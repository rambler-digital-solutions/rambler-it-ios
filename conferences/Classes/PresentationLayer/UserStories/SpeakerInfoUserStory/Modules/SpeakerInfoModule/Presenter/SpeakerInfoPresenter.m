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
    [self.interactor obtainSpeakerWithObjectId:self.stateStorage.speakerObjectId];
}

#pragma mark - SpeakerInfoInteractorOutput

- (void)didObtainSpeaker:(SpeakerPlainObject *)speaker {
    [self.view setupViewWithSpeaker:speaker];
}

#pragma mark - SpeakerInfoModuleInput

- (void)configureCurrentModuleWithSpeakerId:(NSString *)speakerId {
    self.stateStorage.speakerObjectId = speakerId;
}

@end