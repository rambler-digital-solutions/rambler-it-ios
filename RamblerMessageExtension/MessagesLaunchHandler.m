//
//  MessagesLaunchHandler.m
//  Conferences
//
//  Created by Trishina Ekaterina on 16/10/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import "MessagesLaunchHandler.h"

#import "ObjectTransformer.h"
#import "LaunchRouter.h"

#import <CoreSpotlight/CoreSpotlight.h>

@interface MessagesLaunchHandler ()

@property (nonatomic, strong) id<ObjectTransformer> objectTransformer;
@property (nonatomic, strong) id<LaunchRouter> launchRouter;

@end

@implementation MessagesLaunchHandler

#pragma mark - Initialization

- (instancetype)initWithObjectTransformer:(id<ObjectTransformer>)objectTransformer
                             launchRouter:(id<LaunchRouter>)launchRouter {
    self = [super init];
    if (self) {
        _objectTransformer = objectTransformer;
        _launchRouter = launchRouter;
    }
    return self;
}

#pragma mark - <LaunchHandler>

- (BOOL)canHandleLaunchWithActivity:(NSUserActivity *)activity {
    NSString *identifier = [self identifierFromActivity:activity];
    return [self.objectTransformer isCorrectIdentifier:identifier];
}

- (void)handleLaunchWithActivity:(NSUserActivity *)activity {
    NSString *identifier = [self identifierFromActivity:activity];
    id object = [self.objectTransformer objectForIdentifier:identifier];
    [self.launchRouter openScreenWithData:object];
}

#pragma mark - Private methods

- (NSString *)identifierFromActivity:(NSUserActivity *)activity {
    NSDictionary *userInfo = activity.userInfo;
    NSString *activityIdentifier = userInfo[CSSearchableItemActivityIdentifier];
    return activityIdentifier;
}


@end
