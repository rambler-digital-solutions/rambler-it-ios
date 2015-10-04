//
//  RegistrationQuestionService.h
//  Conferences
//
//  Created by Karpushin Artem on 01/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSPredicate;
@class RegistrationQuestion;

typedef void (^RegistrationQuestionCompletionBlock)(RegistrationQuestion *registrationQuestion, NSError *error);

@protocol RegistrationQuestionService <NSObject>

/**
 @author Artem Karpushin
 
 Method is used to obtain RegistrationQuestion object from cache
 
 @param predicate NSPredicate for specifying the filtering parameters
 
 @return RegistrationQuestion object
 */
- (RegistrationQuestion *)obtainRegistrationQuestionWithPredicate:(NSPredicate *)predicate;

/**
 @author Artem Karpushin
 
 Method is used to update RegistrationQuestion object by sending request to server
 
 @param predicate NSPredicate for specifying the filtering parameters
 @param completionBlock RegistrationQuestionCompletionBlock called upon completion the method, and returns RegistrationQuestion object and NSError object if there is any
 */
- (void)updateRegistrationQuestionWithPredicate:(NSPredicate *)predicate completionBlock:(RegistrationQuestionCompletionBlock)completionBlock;

@end
