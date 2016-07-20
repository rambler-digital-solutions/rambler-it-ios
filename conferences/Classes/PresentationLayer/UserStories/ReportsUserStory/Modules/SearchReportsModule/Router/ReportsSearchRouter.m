//
//  ReportsSearchRouter.m
//  Conferences
//
//  Created by k.zinovyev on 19.07.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import "ReportsSearchRouter.h"
#import "EventModuleInput.h"
#import "ReportsSearchModuleInput.h"

@protocol ReportsSearchModuleOutput;

static NSString *const kReportsSearchModuleToEventModuleSegue = @"ReportsSearchModuleToEventModuleSegue";

@implementation ReportsSearchRouter

#pragma mark - ReportListRouterInput

- (void)openEventModuleWithEventObjectId:(NSString *)objectId {
    [[self.transitionHandler openModuleUsingSegue:kReportsSearchModuleToEventModuleSegue] thenChainUsingBlock:^id<RamblerViperModuleOutput>(id<EventModuleInput> moduleInput) {
        [moduleInput configureCurrentModuleWithEventObjectId:objectId];
        return nil;
    }];
}

@end