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

}

#pragma mark - SpeakerInfoInteractorOutput

#pragma mark - SpeakerInfoModuleInput

- (void)configureCurrentModuleWithSpeakerObjectId:(NSString *)objectId {
    self.stateStorage.speakerObjectId = objectId;
}

@end