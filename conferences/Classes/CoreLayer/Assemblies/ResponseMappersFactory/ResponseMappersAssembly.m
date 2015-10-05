//
//  ResponseMappersAssembly.m
//  Conferences
//
//  Created by Egor Tolstoy on 05/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "ResponseMappersAssembly.h"

#import "RCFManagedObjectMapper.h"

#import "RCFResultsResponseObjectFormatter.h"
#import "RCFSingleResponseObjectFormatter.h"

#import "RCFManagedObjectMappingProvider.h"

@implementation ResponseMappersAssembly

#pragma mark - Option matcher

- (id<RCFResponseMapper>)mapperWithType:(NSNumber *)type {
    return [TyphoonDefinition withOption:type matcher:^(TyphoonOptionMatcher *matcher) {
        [matcher caseEqual:@(ResponseMappingResultsType)
                       use:[self resultsResponseMapper]];
        
        [matcher caseEqual:@(ResponseMappingSingleType)
                       use:[self singleResponseMapper]];
    }];
}

#pragma mark - Concrete definitions

- (id<RCFResponseMapper>)resultsResponseMapper {
    return [TyphoonDefinition withClass:[RCFManagedObjectMapper class] configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(initWithMappingProvider:responseObjectFormatter:) parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:[self mappingProvider]];
            [initializer injectParameterWith:[self resultsResponseMapper]];
        }];
    }];
}

- (id<RCFResponseMapper>)singleResponseMapper {
    return [TyphoonDefinition withClass:[RCFManagedObjectMapper class] configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(initWithMappingProvider:responseObjectFormatter:) parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:[self mappingProvider]];
            [initializer injectParameterWith:[self singleResponseMapper]];
        }];
    }];
}

#pragma mark - Object formatters

- (id<RCFResponseObjectFormatter>)resultsObjectFormatter {
    return [TyphoonDefinition withClass:[RCFResultsResponseObjectFormatter class]];
}

- (id<RCFResponseObjectFormatter>)singleObjectFormatter {
    return [TyphoonDefinition withClass:[RCFSingleResponseObjectFormatter class]];
}

#pragma mark - Mapping provider

- (RCFManagedObjectMappingProvider *)mappingProvider {
    return [TyphoonDefinition withClass:[RCFManagedObjectMappingProvider class]];
}

@end
