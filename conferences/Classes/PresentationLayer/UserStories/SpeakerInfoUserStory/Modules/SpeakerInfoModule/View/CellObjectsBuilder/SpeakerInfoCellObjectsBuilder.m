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

@implementation SpeakerInfoCellObjectsBuilder

- (NSArray *)buildObjectsWithSpeaker:(SpeakerPlainObject *)speaker {
    NSMutableArray *cellObjects = [@[] mutableCopy];
    
    SpeakerInfoTableViewCellObject *speakerInfoCellObject = [SpeakerInfoTableViewCellObject objectWithSpeaker:speaker];
    
    [cellObjects addObject:speakerInfoCellObject];
    
    return cellObjects;

}

@end
