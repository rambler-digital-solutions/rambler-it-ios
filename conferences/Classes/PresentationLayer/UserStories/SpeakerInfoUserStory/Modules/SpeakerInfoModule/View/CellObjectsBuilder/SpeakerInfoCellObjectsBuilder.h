//
//  SpeakerInfoCellObjectsBuilder.h
//  Conferences
//
//  Created by Vasyura Anastasiya on 02/08/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SpeakerPlainObject;

@interface SpeakerInfoCellObjectsBuilder : NSObject

- (NSArray *)buildObjectsWithSpeaker:(SpeakerPlainObject *)speaker;

@end
