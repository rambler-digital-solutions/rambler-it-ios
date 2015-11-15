//
//  ReportListRouter.m
//  Conferences
//
//  Created by Karpushin Artem on 08/11/15.
//  Copyright 2015 Rambler. All rights reserved.
//

#import "ReportListRouter.h"
#import "EventModuleInput.h"

static NSString *const kReportListModuleToEventModuleSegue = @"ReportListModuleToEventModuleSegue";

@implementation ReportListRouter

#pragma mark - ReportListRouterInput

- (void)openEventModuleWithEventObjectId:(NSString *)objectId {
    [[self.transitionHandler openModuleUsingSegue:kReportListModuleToEventModuleSegue] thenChainUsingBlock:^id<RamblerViperModuleOutput>(id<EventModuleInput> moduleInput) {
        [moduleInput configureCurrentModuleWithEventObjectId:objectId];
        return nil;
    }];
}

@end