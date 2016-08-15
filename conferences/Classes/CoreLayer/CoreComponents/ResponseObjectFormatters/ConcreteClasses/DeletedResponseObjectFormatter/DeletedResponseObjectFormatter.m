//
//  DeletedResponseObjectFormatter.m
//  Conferences
//
//  Created by k.zinovyev on 15.08.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import "DeletedResponseObjectFormatter.h"
#import "CustomServerResponse.h"

static NSString *const kServerResponseDeletedKey = @"deleted";
static NSString *const kServerResponseUpdatedKey = @"updated";

@implementation DeletedResponseObjectFormatter

- (CustomServerResponse *)formatServerResponse:(NSDictionary *)serverResponse {
    CustomServerResponse *response = [CustomServerResponse new];
    response.deletedObjects = serverResponse[kServerResponseDeletedKey];
    response.updatedObjects = serverResponse[kServerResponseUpdatedKey];
    return response;
}

@end
