// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

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
