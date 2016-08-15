//
//  ResponseConverterFactory.h
//  Conferences
//
//  Created by k.zinovyev on 15.08.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

@protocol ResponseConverter;

/**
 @author Egor Tolstoy
 
 The factory is responsible for creating ResponseMappers
 */
@protocol ResponseConverterFactory <NSObject>

/**
 @author Egor Tolstoy
 
 The method returns a proper ResponseMapper based on a given type
 
 @param type ResponseMappingType
 
 @return id<ResponseMapper>
 */
- (id<ResponseConverter>)converterResponse;

@end
