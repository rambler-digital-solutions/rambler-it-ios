//
//  RCFResponseDeserializer.h
//  Conferences
//
//  Created by Egor Tolstoy on 04/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^RCFResponseDeserializerCompletionBlock)(NSDictionary *response, NSError *error);

/**
 @author Egor Tolstoy
 
 This protocol describes an object responsible for deserializing raw response NSData to NSDictionary. It can have a number of different implementations depending on the server response format.
 */
@protocol RCFResponseDeserializer <NSObject>

/**
 @author Egor Tolstoy
 
 This method initiates the deserializing process of the provided NSData object.
 
 @param responseData The response data from the server
 @param block        The block which is called after the deserializing is over
 */
- (void)deserializeServerResponse:(NSData *)responseData
                  completionBlock:(RCFResponseDeserializerCompletionBlock)block;

@end
