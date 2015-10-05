//
//  RequestSignersFactory.h
//  Conferences
//
//  Created by Egor Tolstoy on 05/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RequestSigningType.h"

@protocol RCFRequestSigner;

/**
 @author Egor Tolstoy
 
 The factory is responsible for creating RequestSigners
 */
@protocol RequestSignersFactory <NSObject>

/**
 @author Egor Tolstoy
 
 The method returns a proper RequestSigner based on a given type
 
 @param type RequestSigningType
 
 @return id<RCFRequestSigner>
 */
- (id<RCFRequestSigner>)requestSignerWithType:(NSNumber *)type;

@end
