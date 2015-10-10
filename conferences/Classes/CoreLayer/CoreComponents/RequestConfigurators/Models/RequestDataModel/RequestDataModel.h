//
//  RequestDataModel.h
//  Conferences
//
//  Created by Egor Tolstoy on 03/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 @author Egor Tolstoy
 
 The model describing the payload structure of NSURLRequest
 */
@interface RequestDataModel : NSObject

@property (strong, nonatomic) NSDictionary *httpHeaderFields;
@property (strong, nonatomic) NSDictionary *queryParameters;
@property (strong, nonatomic) NSData *bodyData;

@end
