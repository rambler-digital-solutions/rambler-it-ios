//
//  RCFResponseMapper.h
//  Conferences
//
//  Created by Egor Tolstoy on 04/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 @author Egor Tolstoy
 
 This protocol describes objects which are responsible for mapping server responses into model objects of any kind.
 */
@protocol ResponseMapper <NSObject>

/**
 @author Egor Tolstoy
 
 This method initiates deserialized response mapping
 
 @param response Deserialized server response
 @param context  Dictionary which has additional data for the mapping operation
 @param error    Mapping error
 
 @return Mapped model object
 */
- (id)mapServerResponse:(id)response
     withMappingContext:(NSDictionary *)context
                  error:(NSError **)error;

@end
