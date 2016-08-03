//
//  SpeakerInfoInteractor.h
//  Conferences
//
//  Created by Karpushin Artem on 16/01/16.
//  Copyright 2016 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SpeakerInfoInteractorInput.h"

@protocol SpeakerInfoInteractorOutput;
@protocol ROSPonsomizer;
@protocol SpeakerService;

@interface SpeakerInfoInteractor : NSObject <SpeakerInfoInteractorInput>

@property (nonatomic, weak) id <SpeakerInfoInteractorOutput> output;
@property (nonatomic, strong) id<ROSPonsomizer> ponsomizer;
@property (nonatomic, strong) id<SpeakerService> speakerService;

@end

