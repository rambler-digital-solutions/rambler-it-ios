//
//  ROCMClassConstraint.h
//  RamblerTyphoonUtils
//
//  Created by Golovko Mikhail on 20/09/16.
//  Copyright © 2016 Rambler&Co. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OCMConstraint.h"

/**
 OCMock constraint checks the argument whether it is a subclass of type
 */
@interface ROCMClassConstraint : OCMConstraint

@property (nonatomic, readonly) Class type;

- (instancetype)initWithClass:(Class)clazz;

@end
