//
//  EventOperationFactory.m
//  Conferences
//
//  Created by Egor Tolstoy on 04/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "EventOperationFactory.h"

#import "NetworkCompoundOperationBuilder.h"
#import "CompoundOperationBuilderConfig.h"
#import "CompoundOperationBase.h"
#import "EventQuery.h"
#import "Event.h"

@interface EventOperationFactory ()

@property (strong, nonatomic) NetworkCompoundOperationBuilder *builder;

@end

@implementation EventOperationFactory

#pragma mark - Initialization

- (instancetype)initWithBuilder:(NetworkCompoundOperationBuilder *)builder {
    self = [super init];
    if (self) {
        _builder = builder;
    }
    return self;
}

#pragma mark - Operations creation

- (CompoundOperationBase *)getEventsOperationWithQuery:(EventQuery *)query {
    CompoundOperationBuilderConfig *config = [CompoundOperationBuilderConfig new];
    
    config.requestConfigurationType = RequestConfigurationRESTType;
    config.requestMethod = @"GET";
    config.serviceName = @"Event";
    config.urlParameters = @[];
    
    config.requestSigningType = RequestSigningParseType;
    
    config.responseDeserializationType = ResponseDeserializationJSONType;
    
    config.responseValidationType = ResponseValidationParseType;
    
    config.responseMappingType = ResponseMappingResultsType;
    config.mappingContext = @{
                              @"kMappingContextManagedObjectClassKey" : NSStringFromClass([Event class])
                              };
    
    return [self.builder buildCompoundOperationWithConfig:config];
}

@end
