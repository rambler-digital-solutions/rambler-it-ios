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

#import "ResponseMappersAssembly.h"

#import "ManagedObjectMapper.h"
#import "DeletedObjectsMapper.h"

#import "DeletedResponseObjectFormatter.h"
#import "ResultsResponseObjectFormatter.h"
#import "SingleResponseObjectFormatter.h"

#import "ManagedObjectMappingProvider.h"
#import "EntityNameFormatterImplementation.h"

@implementation ResponseMappersAssembly

#pragma mark - Option matcher

- (id<ResponseMapper>)mapperWithType:(NSNumber *)type {
    return [TyphoonDefinition withOption:type matcher:^(TyphoonOptionMatcher *matcher) {
        [matcher caseEqual:@(ResponseMappingResultsType)
                       use:[self resultsResponseMapper]];
        
        [matcher caseEqual:@(ResponseMappingSingleType)
                       use:[self singleResponseMapper]];
        
        [matcher caseEqual:@(ResponseMappingDeletedType)
                       use:[self deletedResponseMapper]];
    }];
}

#pragma mark - Concrete definitions

- (id<ResponseMapper>)deletedResponseMapper {
    return [TyphoonDefinition withClass:[DeletedObjectsMapper class] configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(initWithMappingProvider:responseObjectFormatter:entityNameFormatter:) parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:[self mappingProvider]];
            [initializer injectParameterWith:[self deletedObjectFormatter]];
            [initializer injectParameterWith:[self entityNameFormatter]];
        }];
    }];
}

- (id<ResponseMapper>)resultsResponseMapper {
    return [TyphoonDefinition withClass:[ManagedObjectMapper class] configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(initWithMappingProvider:responseObjectFormatter:entityNameFormatter:) parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:[self mappingProvider]];
            [initializer injectParameterWith:[self resultsObjectFormatter]];
            [initializer injectParameterWith:[self entityNameFormatter]];
        }];
    }];
}

- (id<ResponseMapper>)singleResponseMapper {
    return [TyphoonDefinition withClass:[ManagedObjectMapper class]
                          configuration:^(TyphoonDefinition *definition) {
        
                              [definition useInitializer:@selector(initWithMappingProvider:responseObjectFormatter:entityNameFormatter:) parameters:^(TyphoonMethod *initializer) {
            
                                  [initializer injectParameterWith:[self mappingProvider]];
            
                                  [initializer injectParameterWith:[self singleObjectFormatter]];
            
                                  [initializer injectParameterWith:[self entityNameFormatter]];
        
                              }];
    }];
}

#pragma mark - Object formatters

- (id<ResponseObjectFormatter>)deletedObjectFormatter {
    return [TyphoonDefinition withClass:[DeletedResponseObjectFormatter class]];
}

- (id<ResponseObjectFormatter>)resultsObjectFormatter {
    return [TyphoonDefinition withClass:[ResultsResponseObjectFormatter class]];
}

- (id<ResponseObjectFormatter>)singleObjectFormatter {
    return [TyphoonDefinition withClass:[SingleResponseObjectFormatter class]];
}

#pragma mark - Mapping provider

- (ManagedObjectMappingProvider *)mappingProvider {
    return [TyphoonDefinition withClass:[ManagedObjectMappingProvider class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(entityNameFormatter)
                                                    with:[self entityNameFormatter]];
                              [definition injectProperty:@selector(dateFormatter)
                                                    with:[self mappingDateFormatter]];
                              
                          }];
}

#pragma mark - Helpers

- (id<EntityNameFormatter>)entityNameFormatter {
    return [TyphoonDefinition withClass:[EntityNameFormatterImplementation class]];
}

- (NSDateFormatter *)mappingDateFormatter {
    return [TyphoonDefinition withClass:[NSDateFormatter class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectMethod:@selector(setDateFormat:)
                                            parameters:^(TyphoonMethod *method) {
                                                [method injectParameterWith:@"yyyy-MM-dd'T'HH:mm:ss.SSSz"];
                                            }];
                          }];
}

@end
