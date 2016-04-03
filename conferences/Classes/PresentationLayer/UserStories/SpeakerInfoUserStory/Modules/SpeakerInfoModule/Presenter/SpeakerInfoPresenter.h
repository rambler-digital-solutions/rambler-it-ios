//
//  SpeakerInfoPresenter.h
//  Conferences
//
//  Created by Karpushin Artem on 16/01/16.
//  Copyright 2016 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SpeakerInfoViewOutput.h"
#import "SpeakerInfoInteractorOutput.h"
#import "SpeakerInfoModuleInput.h"

@protocol SpeakerInfoViewInput;
@protocol SpeakerInfoInteractorInput;
@protocol SpeakerInfoRouterInput;
@class SpeakerInfoPresenterStateStorage;

@interface SpeakerInfoPresenter : NSObject  <SpeakerInfoViewOutput, SpeakerInfoInteractorOutput, SpeakerInfoModuleInput>

@property (weak, nonatomic) id <SpeakerInfoViewInput> view;
@property (strong, nonatomic) id <SpeakerInfoInteractorInput> interactor;
@property (strong, nonatomic) id <SpeakerInfoRouterInput> router;
@property (strong, nonatomic) SpeakerInfoPresenterStateStorage *stateStorage;

@end

