//
//  ResponseDeserializersFactory.h
//  Conferences
//
//  Created by Egor Tolstoy on 05/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ResponseDeserializationType.h"

@protocol RCFResponseDeserializer;

/**
 @author Egor Tolstoy
 
 The factory is responsible for creating ResponseDeserializers
 */
@protocol ResponseDeserializersFactory <NSObject>

/**
 @author Egor Tolstoy
 
 The method returns a proper ResponseDeserializer based on a given type
 
 @param type ResponseDeserializationType
 
 @return id<ResponseDeserializer>
 */
- (id<RCFResponseDeserializer>)deserializerWithType:(NSNumber *)type;

@end
