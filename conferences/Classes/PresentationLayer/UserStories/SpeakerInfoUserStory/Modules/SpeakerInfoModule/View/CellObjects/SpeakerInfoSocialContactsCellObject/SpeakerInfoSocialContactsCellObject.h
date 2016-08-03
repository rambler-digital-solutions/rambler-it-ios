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

@property (nonatomic, assign, readonly) UIImage *image;
@property (nonatomic, strong, readonly) NSString *link;
@property (nonatomic, strong, readonly) NSString *socialNetworkId;

+ (instancetype)objectWithSocialNetworkAccount:(SocialNetworkAccountPlainObject *)account
                                         image:(UIImage *)image
                                          text:(NSString *)text;
@end
