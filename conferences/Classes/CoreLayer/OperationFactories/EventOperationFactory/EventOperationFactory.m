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

#import "EventOperationFactory.h"

#import "NetworkCompoundOperationBuilder.h"
#import "CompoundOperationBuilderConfig.h"
#import "CompoundOperationBase.h"
#import "EventQuery.h"
#import "Event.h"
#import "NetworkingConstantsHeader.h"

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
    config.requestMethod = kHTTPMethodGET;
    config.serviceName = kEventServiceName;
    config.urlParameters = @[];
    
    config.requestSigningType = RequestSigningParseType;
    
    config.responseDeserializationType = ResponseDeserializationJSONType;
    
    config.responseValidationType = ResponseValidationParseType;
    
    config.responseMappingType = ResponseMappingResultsType;
    config.mappingContext = @{
                              kMappingContextModelClassKey : NSStringFromClass([Event class])
                              };
    
    return [self.builder buildCompoundOperationWithConfig:config];
}

@end
