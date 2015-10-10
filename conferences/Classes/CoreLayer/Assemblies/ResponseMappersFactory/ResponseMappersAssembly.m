//
//  ResponseMappersAssembly.m
//  Conferences
//
//  Created by Egor Tolstoy on 05/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "ResponseMappersAssembly.h"

#import "ManagedObjectMapper.h"

#import "ResultsResponseObjectFormatter.h"
#import "SingleResponseObjectFormatter.h"

#import "ManagedObjectMappingProvider.h"

@implementation ResponseMappersAssembly

#pragma mark - Option matcher

- (id<ResponseMapper>)mapperWithType:(NSNumber *)type {
    return [TyphoonDefinition withOption:type matcher:^(TyphoonOptionMatcher *matcher) {
        [matcher caseEqual:@(ResponseMappingResultsType)
                       use:[self resultsResponseMapper]];
        
        [matcher caseEqual:@(ResponseMappingSingleType)
                       use:[self singleResponseMapper]];
    }];
}

#pragma mark - Concrete definitions

- (id<ResponseMapper>)resultsResponseMapper {
    return [TyphoonDefinition withClass:[ManagedObjectMapper class] configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(initWithMappingProvider:responseObjectFormatter:) parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:[self mappingProvider]];
            [initializer injectParameterWith:[self resultsObjectFormatter]];
        }];
    }];
}

- (id<ResponseMapper>)singleResponseMapper {
    return [TyphoonDefinition withClass:[ManagedObjectMapper class] configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(initWithMappingProvider:responseObjectFormatter:) parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:[self mappingProvider]];
            [initializer injectParameterWith:[self singleObjectFormatter]];
        }];
    }];
}

#pragma mark - Object formatters

- (id<ResponseObjectFormatter>)resultsObjectFormatter {
    return [TyphoonDefinition withClass:[ResultsResponseObjectFormatter class]];
}

- (id<ResponseObjectFormatter>)singleObjectFormatter {
    return [TyphoonDefinition withClass:[SingleResponseObjectFormatter class]];
}

#pragma mark - Mapping provider

- (ManagedObjectMappingProvider *)mappingProvider {
    return [TyphoonDefinition withClass:[ManagedObjectMappingProvider class]];
}

@end
