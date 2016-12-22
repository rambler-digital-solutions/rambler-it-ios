//
//  OCMArg+Rambler.m
//  RamblerTyphoonUtils
//
//  Created by Golovko Mikhail on 19/09/16.
//  Copyright © 2016 Rambler&Co. All rights reserved.
//

#import "OCMArg+Rambler.h"
#import "ROCMProtocolConstraint.h"
#import "ROCMClassConstraint.h"

@implementation OCMArg (Rambler)

+ (id)rds_checkConfirmToProtocols:(Protocol *)first, ... NS_REQUIRES_NIL_TERMINATION {
    NSMutableArray *protocols = [NSMutableArray array];
    va_list args;
    if(first)
    {
        [protocols addObject:first];
        va_start(args, first);
        id obj;
        while((obj = va_arg(args, Protocol *)))
        {
            [protocols addObject:obj];
        }
        va_end(args);
    }
    return [[ROCMProtocolConstraint alloc] initWithProtocols:protocols];
}

+ (id)rds_checkConfirmToProtocolsArray:(NSArray *)protocols {
    return [[ROCMProtocolConstraint alloc] initWithProtocols:protocols];
}

+ (id)rds_checkConfirmToClass:(Class)clazz {
    return [[ROCMClassConstraint alloc] initWithClass:clazz];
}

@end
