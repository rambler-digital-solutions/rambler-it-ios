//
//  ROCMClassConstraint.m
//  RamblerTyphoonUtils
//
//  Created by Golovko Mikhail on 20/09/16.
//  Copyright © 2016 Rambler&Co. All rights reserved.
//

#import "ROCMClassConstraint.h"

@implementation ROCMClassConstraint

- (instancetype)initWithClass:(Class)clazz {
    self = [super init];
    if (self) {
        _type = clazz;
    }
    return self;
}

- (BOOL)evaluate:(id)value {
    return [value isKindOfClass:self.type];
}

@end
