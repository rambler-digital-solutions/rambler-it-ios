//
//  EventListRouter.m
//  Conferences
//
//  Created by Karpushin Artem on 12/10/15.
//  Copyright 2015 Rambler. All rights reserved.
//

#import "EventListRouter.h"
#import "EventModuleInput.h"

static NSString *const kEventListModuleToEventModuleSegue = @"EventListModuleToEventModuleSegue";

@implementation EventListRouter

#pragma mark - EventListRouterInput

- (void)openEventModuleWithEventObjectId:(NSString *)objectId {
    [[self.transitionHandler openModuleUsingSegue:kEventListModuleToEventModuleSegue] thenChainUsingBlock:^id<RamblerViperModuleOutput>(id<EventModuleInput> moduleInput) {
        [moduleInput configureCurrentModuleWithEventObjectId:objectId];
        return nil;
    }];
}

@end