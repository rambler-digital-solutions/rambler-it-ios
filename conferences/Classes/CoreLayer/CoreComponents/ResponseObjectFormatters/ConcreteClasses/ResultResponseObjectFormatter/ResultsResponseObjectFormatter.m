//
//  RCFResultsResponseObjectFormatter.m
//  Conferences
//
//  Created by Egor Tolstoy on 04/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "ResultsResponseObjectFormatter.h"

static NSString *const kServerResponseResultsKey = @"results";

@implementation ResultsResponseObjectFormatter

- (id)formatServerResponse:(NSDictionary *)serverResponse {
    NSArray *formattedResponse = serverResponse[kServerResponseResultsKey];
    return formattedResponse;
}

@end
