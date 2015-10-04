//
//  SocialNetworkAccountService.h
//  Conferences
//
//  Created by Karpushin Artem on 01/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSPredicate;
@class SocialNetworkAccount;

typedef void (^SocialNetworkAccountCompletionBlock)(SocialNetworkAccount *socialNetworkAccount, NSError *error);

@protocol SocialNetworkAccountService <NSObject>

/**
 @author Artem Karpushin
 
 Method is used to obtain SocialNetworkAccount object from cache
 
 @param predicate NSPredicate for specifying the filtering parameters
 
 @return SocialNetworkAccount object
 */
- (SocialNetworkAccount *)obtainSocialNetworkAccountWithPredicate:(NSPredicate *)predicate;

/**
 @author Artem Karpushin
 
 Method is used to update SocialNetworkAccount object by sending request to server
 
 @param predicate NSPredicate for specifying the filtering parameters
 @param completionBlock SocialNetworkAccountCompletionBlock called upon completion the method, and returns SocialNetworkAccount object and NSError object if there is any
 */
- (void)updateSocialNetworkAccountWithPredicate:(NSPredicate *)predicate completionBlock:(SocialNetworkAccountCompletionBlock)completionBlock;

@end
