//
//  JSONDeletedObjectsTransformOperation.h
//  Conferences
//
//  Created by k.zinovyev on 15.08.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AsyncOperation.h"
#import "ResponseConverter.h"
#import "ChainableOperation.h"

@interface ResponseConverterOperation : AsyncOperation <ChainableOperation>

+ (instancetype)operationWithResponseConverter:(id<ResponseConverter>)responseConverter;

@end
