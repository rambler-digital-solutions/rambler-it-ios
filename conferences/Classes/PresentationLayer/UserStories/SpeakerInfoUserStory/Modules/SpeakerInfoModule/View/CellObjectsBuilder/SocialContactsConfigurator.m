//
//  SocialContactsConfigurator.m
//  Conferences
//
//  Created by Vasyura Anastasiya on 03/08/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import "SocialContactsConfigurator.h"
#import "SocialNetworkAccountPlainObject.h"
#import "SocialNetworkType.h"
#import "LocalizedStrings.h"

@implementation SocialContactsConfigurator

- (NSString *)configureNameForSocialAccount:(SocialNetworkAccountPlainObject *)account {
    NSDictionary *names = [self socialNetworkNameWithAccount:account];
    NSString *name = names[account.type];
    return name;
}

- (NSString *)configureImageForSocialAccount:(SocialNetworkAccountPlainObject *)account {
    NSDictionary *imageNames = [self socialNetworkImages];
    NSString *name = imageNames[account.type];
    NSString *image = name;
    
    return image;
}

- (NSDictionary *)socialNetworkImages {
    return @{
             @(SocialNetworkUndefinedType) : @"ic-web",
             @(SocialNetworkFacebookType) : @"ic-facebook",
             @(SocialNetworkTwitterType) : @"ic-twitter",
             @(SocialNetworkGitHubType) : @"ic-web",
             @(SocialNetworkLinkedInType) : @"ic-linkedin",
             @(SocialNetworkVkontakteType) : @"ic-web",
             @(SocialNetworkEmailType) : @"ic-mail",
             @(SocialNetworkInstagramType) : @"ic-instagram",
             @(SocialNetworkWebsiteType) : @"ic-web"
             };
}

- (NSDictionary *)socialNetworkNameWithAccount:(SocialNetworkAccountPlainObject *)account {
    return @{
             @(SocialNetworkUndefinedType) : account.profileLink,
             @(SocialNetworkFacebookType) : RCLocalize(kSpeakInfoFacebookAccountTitle),
             @(SocialNetworkTwitterType) : RCLocalize(kSpeakInfoTwitterAccountTitle),
             @(SocialNetworkGitHubType) : RCLocalize(kSpeakInfoGithubAccountTitle),
             @(SocialNetworkLinkedInType) : RCLocalize(kSpeakInfoLinkedInAccountTitle),
             @(SocialNetworkVkontakteType) : RCLocalize(kSpeakInfoVkontakteAccountTitle),
             @(SocialNetworkEmailType) : account.profileLink,
             @(SocialNetworkInstagramType) : RCLocalize(kSpeakInfoInstagramAccountTitle),
             @(SocialNetworkWebsiteType) : account.profileLink
             };
}

@end
