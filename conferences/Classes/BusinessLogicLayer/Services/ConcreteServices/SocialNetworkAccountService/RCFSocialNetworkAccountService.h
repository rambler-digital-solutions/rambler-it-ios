//
//  RCFSocialNetworkAccountService.h
//  Conferences
//
//  Created by Karpushin Artem on 01/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSPredicate;
@class SocialNetworkAccount;

typedef void (^RCFSocialNetworkAccountCompletionBlock)(SocialNetworkAccount *socialNetworkAccount, NSError *error);

@protocol RCFSocialNetworkAccountService <NSObject>

- (SocialNetworkAccount *)obtainSocialNetworkAccountWithPredicate:(NSPredicate *)predicate;

- (void)updateSocialNetworkAccountWithPredicate:(NSPredicate *)predicate completionBlock:(RCFSocialNetworkAccountCompletionBlock)completionBlock;

@end
