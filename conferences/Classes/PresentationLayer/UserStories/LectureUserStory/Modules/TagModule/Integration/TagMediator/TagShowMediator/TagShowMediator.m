//
// TagShowMediator.m
// LiveJournal
// 
// Created by Golovko Mikhail on 29/12/15.
// Copyright © 2015 Rambler&Co. All rights reserved.
//

#import "TagShowMediator.h"
#import "TagModuleInput.h"
#import "TagModuleConfig.h"

const NSInteger kCountShowLines = 3;

@implementation TagShowMediator

#pragma mark - методы TagMediatorInput

- (void)configureWithObjectDescriptor:(TagObjectDescriptor *)objectDescriptor
                       tagModuleInput:(id <TagModuleInput>)tagModuleInput {

    TagModuleConfig *moduleConfig = [[TagModuleConfig alloc] initWithObjectDescriptor:objectDescriptor];
    moduleConfig.verticalAlign = YES;
    moduleConfig.enableAddButton = NO;
    moduleConfig.enableRemoveButton = NO;
    moduleConfig.numberOfShowLine = kCountShowLines;

    [tagModuleInput configureModuleWithModuleConfig:moduleConfig
                                       moduleOutput:nil];
}

@end