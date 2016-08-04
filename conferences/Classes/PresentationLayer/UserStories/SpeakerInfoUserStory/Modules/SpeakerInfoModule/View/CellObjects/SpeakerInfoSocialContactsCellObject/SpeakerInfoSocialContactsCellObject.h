//
//  SpeakerInfoSocialContactsCellObject.h
//  Conferences
//
//  Created by Vasyura Anastasiya on 03/08/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Nimbus/NimbusModels.h>
#import "SocialNetworkType.h"

@class SocialNetworkAccountPlainObject;

@interface SpeakerInfoSocialContactsCellObject : NSObject <NICellObject>

@property (nonatomic, assign, readonly) NSString *image;
@property (nonatomic, strong, readonly) NSString *link;
@property (nonatomic, strong, readonly) NSString *name;

+ (instancetype)objectWithSocialNetworkAccount:(SocialNetworkAccountPlainObject *)account
                                         image:(NSString *)image
                                          text:(NSString *)text;
@end
