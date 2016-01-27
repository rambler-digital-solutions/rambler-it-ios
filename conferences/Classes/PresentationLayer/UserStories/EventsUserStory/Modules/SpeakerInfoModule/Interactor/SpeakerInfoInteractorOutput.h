//
//  SpeakerInfoInteractorOutput.h
//  Conferences
//
//  Created by Karpushin Artem on 16/01/16.
//  Copyright 2016 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SpeakerPlainObject;

@protocol SpeakerInfoInteractorOutput <NSObject>

/**
 @author Artem Karpushin
 
 Method is used to inform presenter that Speaker object was obtained
 
 @param speaker SpeakerPlainObject object
 */
- (void)didObtainSpeaker:(SpeakerPlainObject *)speaker;

@end

