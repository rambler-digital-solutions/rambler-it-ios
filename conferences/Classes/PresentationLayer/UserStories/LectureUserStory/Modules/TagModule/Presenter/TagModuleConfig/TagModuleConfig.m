//
// TagModuleConfig.m
// LiveJournal
// 
// Created by Golovko Mikhail on 17/12/15.
// Copyright © 2015 Rambler&Co. All rights reserved.
//

#import "TagModuleConfig.h"
#import "TagObjectDescriptor.h"

@implementation TagModuleConfig

- (instancetype)initWithObjectDescriptor:(TagObjectDescriptor *)objectDescriptor {
    self = [super init];
    if (self) {
        _objectDescriptor = objectDescriptor;
    }

    return self;
}

- (instancetype)initWithObjectDescriptor:(TagObjectDescriptor *)objectDescriptor
                filteredObjectDescriptor:(TagObjectDescriptor *)filteredObjectDescriptor {
    self = [super init];
    if (self) {
        _objectDescriptor = objectDescriptor;
        _filteredObjectDescriptor = filteredObjectDescriptor;
    }

    return self;
}


@end