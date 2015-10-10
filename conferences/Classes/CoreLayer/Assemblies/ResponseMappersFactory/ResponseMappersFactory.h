//
//  ResponseMappersFactory.h
//  Conferences
//
//  Created by Egor Tolstoy on 05/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ResponseMappingType.h"

@protocol ResponseMapper;

/**
 @author Egor Tolstoy
 
 The factory is responsible for creating ResponseMappers
 */
@protocol ResponseMappersFactory <NSObject>

/**
 @author Egor Tolstoy
 
 The method returns a proper ResponseMapper based on a given type
 
 @param type ResponseMappingType
 
 @return id<ResponseMapper>
 */
- (id<ResponseMapper>)mapperWithType:(NSNumber *)type;

@end
