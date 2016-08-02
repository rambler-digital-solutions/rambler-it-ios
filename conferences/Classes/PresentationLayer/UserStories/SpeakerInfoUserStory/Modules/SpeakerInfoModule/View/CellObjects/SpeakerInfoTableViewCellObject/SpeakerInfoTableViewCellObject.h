//
//  SpeakerInfoTableViewCellObject.h
//  Conferences
//
//  Created by Karpushin Artem on 20/03/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Nimbus/NimbusModels.h>

@class SpeakerPlainObject;

@interface SpeakerInfoTableViewCellObject : NSObject <NICellObject>

@property (nonatomic, strong, readonly) NSString *speakerName;
@property (nonatomic, strong, readonly) NSString *companyName;
@property (nonatomic, strong, readonly) NSString *speakerDescription;

+ (instancetype)objectWithSpeaker:(SpeakerPlainObject *)speaker;

@end
