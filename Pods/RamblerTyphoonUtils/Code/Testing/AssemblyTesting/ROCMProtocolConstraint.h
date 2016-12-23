//
//  ROCMProtocolConstraint.h
//  RamblerTyphoonUtils
//
//  Created by Golovko Mikhail on 19/09/16.
//  Copyright © 2016 Rambler&Co. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OCMConstraint.h"
    
/**
 OCMock constraint checks the argument to conform protocols
 */
@interface ROCMProtocolConstraint : OCMConstraint

@property (nonatomic, copy, readonly) NSArray *protocols;

- (instancetype)initWithProtocols:(NSArray *)protocols;

@end
