//
//  JSONResponseDeserializer.h
//  Conferences
//
//  Created by Egor Tolstoy on 04/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

#import "ResponseDeserializer.h"

/**
 @author Egor Tolstoy
 
 This implementation of the RCFResponseDeserializer protocol is responsible for deserializing json-reponses from the remote server.
 */
@interface JSONResponseDeserializer : AFJSONResponseSerializer <ResponseDeserializer>

@end
