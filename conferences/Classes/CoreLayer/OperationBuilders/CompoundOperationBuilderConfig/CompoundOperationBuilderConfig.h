//
//  CompoundOperationBuilderConfig.h
//  Conferences
//
//  Created by Egor Tolstoy on 04/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RequestConfigurationType.h"
#import "RequestSigningType.h"
#import "NetworkConnectionType.h"
#import "ResponseDeserializationType.h"
#import "ResponseValidationType.h"
#import "ResponseMappingType.h"

typedef id(^CompoundOperationInputDataMappingBlock)(id data);

@interface CompoundOperationBuilderConfig : NSObject

// General parameters
@property (nonatomic, strong) id inputQueueData;
@property (nonatomic, copy) CompoundOperationInputDataMappingBlock inputDataMappingBlock;

// Request configuration operation parameters
@property (nonatomic, assign) RequestConfigurationType requestConfigurationType;
@property (nonatomic, assign) NSString *requestMethod;
@property (nonatomic, assign) NSString *serviceName;
@property (nonatomic, strong) NSArray *urlParameters;

// Request signing operation parameters
@property (nonatomic, assign) RequestSigningType requestSigningType;

// Response deserialization operation parameters
@property (nonatomic, assign) ResponseDeserializationType responseDeserializationType;

// Validation operation parameters
@property (nonatomic, assign) ResponseValidationType responseValidationType;

// Mapping operation type
@property (nonatomic, assign) ResponseMappingType responseMappingType;
@property (nonatomic, strong) NSDictionary *mappingContext;

@end
