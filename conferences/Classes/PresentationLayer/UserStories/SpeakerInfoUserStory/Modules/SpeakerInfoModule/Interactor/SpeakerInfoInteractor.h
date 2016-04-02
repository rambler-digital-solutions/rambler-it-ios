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

@interface SpeakerInfoInteractor : NSObject <SpeakerInfoInteractorInput>

@property (weak, nonatomic) id <SpeakerInfoInteractorOutput> output;

@end

