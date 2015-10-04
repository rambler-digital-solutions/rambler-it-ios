//
//  SpeakerService.h
//  Conferences
//
//  Created by Karpushin Artem on 01/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSPredicate;
@class Speaker;

typedef void (^SpeakerCompletionBlock)(Speaker *speaker, NSError *error);

/**
 @author Artem Karpushin
 
 The service is designed to obtain / update Speaker objects
 */
@protocol SpeakerService <NSObject>

/**
 @author Artem Karpushin
 
 Method is used to obtain Speaker object from cache
 
 @param predicate NSPredicate for specifying the filtering parameters
 
 @return Speaker object
 */
- (Speaker *)obtainSpeakerWithPredicate:(NSPredicate *)predicate;

/**
 @author Artem Karpushin
 
 Method is used to update Speaker object by sending request to server
 
 @param predicate NSPredicate for specifying the filtering parameters
 @param completionBlock SpeakerCompletionBlock called upon completion the method, and returns Speaker object and NSError object if there is any
 */
- (void)updateSpeakerWithPredicate:(NSPredicate *)predicate completionBlock:(SpeakerCompletionBlock)completionBlock;

@end
