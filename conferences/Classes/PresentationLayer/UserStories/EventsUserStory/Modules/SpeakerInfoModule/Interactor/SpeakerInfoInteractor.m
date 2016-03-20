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

@interface SpeakerInfoInteractor()

@end

@implementation SpeakerInfoInteractor

#pragma mark - SpeakerInfoInteractorInput

- (void)obtainSpeakerWithObjectId:(NSString *)objectId {
    /**
     @author Artem Karpushin
     
     There is no service to fetch Speaker yet, so create mockSpeaker to simulate the operation of the service
     */
    
    SpeakerPlainObject * mockSpeaker = [SpeakerPlainObject new];
    mockSpeaker.name = @"Ray Wenderlich";
    mockSpeaker.companyName = @"Rambler&Co";
    mockSpeaker.biography = @"Method swizzling is the process of changing the implementation of an existing selector. It’s a technique made possible by the fact that method invocations in Objective-C can be changed at runtime, by changing how selectors are mapped to underlying functions in a class’s dispatch table.";
    
    [self.output didObtainSpeaker:mockSpeaker];
}

@end