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

static NSString *const kSocialNetworksSectionName = @"Контакты";

@implementation SpeakerInfoCellObjectsBuilder

- (NSArray *)buildObjectsWithSpeaker:(SpeakerPlainObject *)speaker {
    NSMutableArray *cellObjects = [NSMutableArray new];
    
    SpeakerInfoTableViewCellObject *speakerInfoCellObject = [SpeakerInfoTableViewCellObject objectWithSpeaker:speaker];
    
    [cellObjects addObject:speakerInfoCellObject];
    
    if (speaker.socialNetworkAccounts.count) {
        NSArray *socialAccounts = [self buildSocialContactsCellObjectsWithAccounts:[speaker.socialNetworkAccounts allObjects]];
        [cellObjects addObjectsFromArray:socialAccounts];
    }
    
    return cellObjects;

}

- (NSArray *)buildSocialContactsCellObjectsWithAccounts:(NSArray *)socialAccounts {
    
    NSMutableArray *cellObjects = [NSMutableArray new];
    SpeakerInfoSectionHeaderCellObject *cellObject = [SpeakerInfoSectionHeaderCellObject objectWithText:kSocialNetworksSectionName];
    [cellObjects addObject:cellObject];
    
    for (SocialNetworkAccountPlainObject *account in socialAccounts) {
        UIImage *image = [self.configurator configureImageForSocialAccount:account];
        NSString *text = [self.configurator configureNameForSocialAccount:account];
        SpeakerInfoSocialContactsCellObject *cellObject = [SpeakerInfoSocialContactsCellObject objectWithSocialNetworkAccount:account
                                                                                                                        image:image
                                                                                                                         text:text];
        [cellObjects addObject:cellObject];
    }
    
    return [cellObjects copy];
}

@end
