//
//  SocialContactsConfigurator.h
//  Conferences
//
//  Created by Vasyura Anastasiya on 03/08/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SocialNetworkAccountPlainObject;

@interface SocialContactsConfigurator : NSObject

- (NSString *)configureNameForSocialAccount:(SocialNetworkAccountPlainObject *)account;
- (NSString *)configureImageForSocialAccount:(SocialNetworkAccountPlainObject *)account;

@end
