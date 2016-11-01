//
//  MessagesLaunchHandler.h
//  Conferences
//
//  Created by Trishina Ekaterina on 16/10/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LaunchHandler.h"

@protocol ObjectTransformer;
@protocol LaunchRouter;

/**
 @author Trishina Ekaterina

 This LaunchHandler is capable od handling application launch from the iMessage app
 */
@interface MessagesLaunchHandler : NSObject <LaunchHandler>

- (instancetype)initWithObjectTransformer:(id<ObjectTransformer>)objectTransformer
                             launchRouter:(id<LaunchRouter>)launchRouter;

@end
