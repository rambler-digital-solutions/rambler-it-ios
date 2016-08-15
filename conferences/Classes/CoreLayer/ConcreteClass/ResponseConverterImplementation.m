//
//  TransfromJSONImplementation.m
//  Conferences
//
//  Created by k.zinovyev on 15.08.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import "ResponseConverterImplementation.h"

static NSString *const kEventAttributesKey = @"attributes";
static NSString *const kEventDeletedKey = @"deleted";
static NSString *const kEventUpdatedKey = @"updated";
static NSString *const kServerResponseResultsKey = @"data";

@implementation ResponseConverterImplementation

- (NSDictionary *)convertFromResponse:(NSDictionary *)dict {
    NSArray *data = [self.responseFormatter formatServerResponse:dict];
    
    NSMutableArray *deletedObjects = [NSMutableArray new];
    NSMutableArray *updatedObjects = [NSMutableArray new];
    for (NSDictionary *dict in data) {
        if (dict[kEventAttributesKey][kEventDeletedKey]) {
            [deletedObjects addObject:dict];
        }
        else {
            [updatedObjects addObject:dict];
        }
    }
    NSDictionary *resultDict = @{
                                 kEventDeletedKey : deletedObjects,
                                 kEventUpdatedKey : updatedObjects
                                 };
    
    return resultDict;
}

@end
