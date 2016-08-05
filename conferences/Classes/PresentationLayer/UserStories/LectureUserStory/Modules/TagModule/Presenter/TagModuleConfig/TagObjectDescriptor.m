//
// TagObjectDescriptor.m
// LiveJournal
// 
// Created by Golovko Mikhail on 24/12/15.
// Copyright © 2015 Rambler&Co. All rights reserved.
//

#import "TagObjectDescriptor.h"


@implementation TagObjectDescriptor

- (instancetype)initWithObjectName:(NSString *)objectName
                           idValue:(NSString *)idValue {
    self = [super init];
    if (self) {
        _objectName = objectName;
        _idValue = idValue;
    }

    return self;
}

@end