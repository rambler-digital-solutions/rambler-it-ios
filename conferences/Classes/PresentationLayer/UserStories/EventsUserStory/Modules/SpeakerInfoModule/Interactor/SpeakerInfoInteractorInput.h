//
//  SpeakerInfoInteractorInput.h
//  Conferences
//
//  Created by Karpushin Artem on 16/01/16.
//  Copyright 2016 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SpeakerInfoInteractorInput <NSObject>

/**
 @author Artem Karpushin
 
 Method is used to obtain Speaker object
 
 @param objectId NString object
 */
- (void)obtainSpeakerWithObjectId:(NSString *)objectId;

@end

