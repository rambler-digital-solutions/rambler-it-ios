//
//  ROCMProtocolConstraint.m
//  RamblerTyphoonUtils
//
//  Created by Golovko Mikhail on 19/09/16.
//  Copyright © 2016 Rambler&Co. All rights reserved.
//

#import "ROCMProtocolConstraint.h"

@implementation ROCMProtocolConstraint

- (instancetype)initWithProtocols:(NSArray *)protocols {
    self = [super init];
    if (self) {
        _protocols = [protocols copy];
    }
    
    return self;
}

- (BOOL)evaluate:(id)value {
    for (Protocol *protocol in self.protocols) {
        if (![value conformsToProtocol:protocol]) {
            return NO;
        }
    }
    return YES;
}

@end
