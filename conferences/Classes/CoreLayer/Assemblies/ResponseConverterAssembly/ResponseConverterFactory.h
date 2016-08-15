//
//  ResponseConverterFactory.h
//  Conferences
//
//  Created by k.zinovyev on 15.08.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

@protocol ResponseConverter;

/**
 @author Konstantin Zinovyev
 
 The factory is responsible for creating ResponseConverter
 */
@protocol ResponseConverterFactory <NSObject>

/**
 @author Konstantin Zinovyev
 
 The method returns a ResponseConverter
 
 @return id<ResponseConverter>
 */
- (id<ResponseConverter>)converterResponse;

@end
