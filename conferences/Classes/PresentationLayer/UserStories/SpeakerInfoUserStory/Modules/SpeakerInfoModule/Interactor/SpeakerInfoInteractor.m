//
//  SpeakerInfoInteractor.m
//  Conferences
//
//  Created by Karpushin Artem on 16/01/16.
//  Copyright 2016 Rambler. All rights reserved.
//

#import "SpeakerInfoInteractor.h"
#import "SpeakerInfoInteractorOutput.h"
#import "SpeakerPlainObject.h"
#import "SpeakerModelObject.h"
#import "ROSPonsomizer.h"
#import "SpeakerService.h"

@interface SpeakerInfoInteractor()

@end

@implementation SpeakerInfoInteractor

#pragma mark - SpeakerInfoInteractorInput

- (SpeakerPlainObject *)obtainSpeakerWithSpeakerId:(NSString *)speakerId {
    
    SpeakerModelObject *speaker = [self.speakerService obtainSpeakerWithSpeakerId:speakerId];
    SpeakerPlainObject *plainSpeaker = [self.ponsomizer convertObject:speaker];
    
    return plainSpeaker;
}

@end