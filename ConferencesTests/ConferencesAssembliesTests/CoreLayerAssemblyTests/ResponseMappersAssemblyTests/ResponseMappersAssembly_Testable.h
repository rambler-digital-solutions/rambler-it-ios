//
//  ResponseMappersAssembly_Testable.h
//  Conferences
//
//  Created by Karpushin Artem on 16/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "ResponseMappersAssembly.h"

@protocol ResponseObjectFormatter;
@protocol ResponseObjectFormatter;
@class ManagedObjectMappingProvider;

@interface ResponseMappersAssembly ()

- (id<ResponseObjectFormatter>)resultsObjectFormatter;
- (id<ResponseObjectFormatter>)singleObjectFormatter;
- (ManagedObjectMappingProvider *)mappingProvider;

@end
