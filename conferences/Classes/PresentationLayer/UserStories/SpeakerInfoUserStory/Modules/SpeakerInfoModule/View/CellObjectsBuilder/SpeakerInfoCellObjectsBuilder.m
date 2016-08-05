//
//  SpeakerInfoCellObjectsBuilder.m
//  Conferences
//
//  Created by Vasyura Anastasiya on 02/08/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import "SpeakerInfoCellObjectsBuilder.h"
#import "SpeakerInfoTableViewCellObject.h"
#import "SpeakerInfoSocialContactsCellObject.h"
#import "SocialNetworkAccountPlainObject.h"
#import "SocialContactsConfigurator.h"
#import "SpeakerInfoSectionHeaderCellObject.h"
#import "SpeakerPlainObject.h"
#import "LocalizedStrings.h"

@implementation SpeakerInfoCellObjectsBuilder

- (NSArray *)buildObjectsWithSpeaker:(SpeakerPlainObject *)speaker {
    NSMutableArray *cellObjects = [NSMutableArray new];
    
    SpeakerInfoTableViewCellObject *speakerInfoCellObject = [SpeakerInfoTableViewCellObject objectWithSpeaker:speaker];
    
    [cellObjects addObject:speakerInfoCellObject];
    
    NSMutableArray *accounts = [[speaker.socialNetworkAccounts allObjects] mutableCopy];
    NSInteger websiteIndex = [accounts indexOfObjectPassingTest:^BOOL(SocialNetworkAccountPlainObject * _Nonnull object, NSUInteger idx, BOOL * _Nonnull stop) {
        return object.type.integerValue == SocialNetworkWebsiteType;
    }];
    
    if (websiteIndex != NSNotFound) {
        SocialNetworkAccountPlainObject *website = accounts[websiteIndex];
        NSArray *websiteCellObjects = [self buildWebsiteCellObjectsWithAccount:website];
        [cellObjects addObjectsFromArray:websiteCellObjects];
        [accounts removeObject:website];
    }
    
    if (accounts.count) {
        NSArray *socialAccounts = [self buildSocialContactsCellObjectsWithAccounts:accounts];
        [cellObjects addObjectsFromArray:socialAccounts];
    }
    
    return cellObjects;

}

- (NSArray *)buildWebsiteCellObjectsWithAccount:(SocialNetworkAccountPlainObject *)account {
    NSMutableArray *cellObjects = [NSMutableArray new];
    SpeakerInfoSectionHeaderCellObject *headerCellObject = [SpeakerInfoSectionHeaderCellObject objectWithText:RCLocalize(kSpeakerInfoWebsiteSectionName)];
    [cellObjects addObject:headerCellObject];
    
    NSString *image = [self.configurator configureImageForSocialAccount:account];
    NSString *text = [self.configurator configureNameForSocialAccount:account];
    SpeakerInfoSocialContactsCellObject *cellObject = [SpeakerInfoSocialContactsCellObject objectWithSocialNetworkAccount:account
                                                                                                                    image:image
                                                                                                                     text:text];
    [cellObjects addObject:cellObject];

    return [cellObjects copy];
}

- (NSArray *)buildSocialContactsCellObjectsWithAccounts:(NSArray *)socialAccounts {
    
    NSMutableArray *cellObjects = [NSMutableArray new];
    SpeakerInfoSectionHeaderCellObject *cellObject = [SpeakerInfoSectionHeaderCellObject objectWithText:RCLocalize(kSpeakerInfoSocialNetworksSectionName)];
    [cellObjects addObject:cellObject];
    
    for (SocialNetworkAccountPlainObject *account in socialAccounts) {
        NSString *image = [self.configurator configureImageForSocialAccount:account];
        NSString *text = [self.configurator configureNameForSocialAccount:account];
        SpeakerInfoSocialContactsCellObject *cellObject = [SpeakerInfoSocialContactsCellObject objectWithSocialNetworkAccount:account
                                                                                                                        image:image
                                                                                                                         text:text];
        [cellObjects addObject:cellObject];
    }
    
    return [cellObjects copy];
}

@end
