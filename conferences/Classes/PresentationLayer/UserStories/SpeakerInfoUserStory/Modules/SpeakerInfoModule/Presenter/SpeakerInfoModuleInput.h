//
//  SpeakerInfoModuleInput.h
//  Conferences
//
//  Created by Karpushin Artem on 16/01/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ViperMcFlurry/ViperMcFlurry.h>

@protocol SpeakerInfoModuleInput <RamblerViperModuleInput>

/**
 @author Artem Karpushin
 
 Method is used to cunfigure speaker info module
 
 @param objectId Speaker object id
 */
- (void)configureCurrentModuleWithSpeakerId:(NSString *)speakerId;

@end
