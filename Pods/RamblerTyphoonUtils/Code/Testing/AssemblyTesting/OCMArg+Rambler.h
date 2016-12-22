//
//  OCMArg+Rambler.h
//  RamblerTyphoonUtils
//
//  Created by Golovko Mikhail on 19/09/16.
//  Copyright © 2016 Rambler&Co. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OCMArg.h"

#define ROCMConfirmToProtocols(first, ...) ([OCMArg rds_checkConfirmToProtocolsArray:@[first, ##__VA_ARGS__]])

#define ROCMConfirmToClass(clazz) [OCMArg rds_checkConfirmToClass:clazz]

/**
 Extension OCMArg for perfoming check on using class constraint (ROCMClassConstraint) or
 protocol constraint (ROCMProtocolConstraint)
 */
@interface OCMArg (Rambler)

+ (id)rds_checkConfirmToProtocols:(Protocol *)first,... NS_REQUIRES_NIL_TERMINATION;

+ (id)rds_checkConfirmToProtocolsArray:(NSArray *)protocols;

+ (id)rds_checkConfirmToClass:(Class)clazz;

@end
