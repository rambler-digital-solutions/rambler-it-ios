//
//  SpeakerPrototypeMapper.m
//  Conferences
//
//  Created by k.zinovyev on 19.07.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import "SpeakerPrototypeMapper.h"

#import "SpeakerManagedObject.h"
#import "SpeakerPlainObject.h"

@implementation SpeakerPrototypeMapper

- (void)fillObject:(SpeakerPlainObject *)filledObject withObject:(SpeakerManagedObject *)object {
    filledObject.biography = object.biography;
    filledObject.name = object.name;
    filledObject.imageUrl = [NSURL URLWithString:object.imageLink];
    filledObject.socialNetworkAccounts = [object.socialNetworkAccounts allObjects];
    filledObject.companyName = object.company;
    filledObject.objectId = object.speakerId;

}

@end
