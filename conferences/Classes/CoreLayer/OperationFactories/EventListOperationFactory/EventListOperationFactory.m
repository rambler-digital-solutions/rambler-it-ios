// Copyright (c) 2015 RAMBLER&Co
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "EventListOperationFactory.h"

#import "NetworkCompoundOperationBuilder.h"
#import "CompoundOperationBuilderConfig.h"
#import "CompoundOperationBase.h"
#import "EventListQuery.h"
#import "EventManagedObject.h"
#import "NetworkingConstantsHeader.h"
#import "QueryTransformer.h"

@interface EventListOperationFactory ()

@property (nonatomic, strong) NetworkCompoundOperationBuilder *networkOperationBuilder;
@property (nonatomic, strong) id<QueryTransformer> queryTransformer;

@end

@implementation EventListOperationFactory

#pragma mark - Initialization

- (instancetype)initWithBuilder:(NetworkCompoundOperationBuilder *)builder
               queryTransformer:(id<QueryTransformer>)queryTransformer {
    self = [super init];
    if (self) {
        _networkOperationBuilder = builder;
        _queryTransformer = queryTransformer;
    }
    return self;
}

#pragma mark - Operations creation

- (CompoundOperationBase *)getEventsOperationWithQuery:(EventListQuery *)query {
    CompoundOperationBuilderConfig *config = [CompoundOperationBuilderConfig new];
    
    config.requestConfigurationType = RequestConfigurationRESTType;
    config.requestMethod = kHTTPMethodGET;
    config.serviceName = kEventServiceName;
    NSArray *urlParameters = [self.queryTransformer deriveUrlParametersFromQuery:query];
    config.urlParameters = urlParameters;
    
    config.requestSigningType = RequestSigningDisabledType;
    
    config.responseDeserializationType = ResponseDeserializationJSONType;
    
    config.responseValidationType = ResponseValidationParseType;
    
    config.responseMappingType = ResponseMappingResultsType;
    config.mappingContext = @{
                              kMappingContextModelClassKey : NSStringFromClass([EventManagedObject class])
                              };
    
    return [self.networkOperationBuilder buildCompoundOperationWithConfig:config];
}

@end
