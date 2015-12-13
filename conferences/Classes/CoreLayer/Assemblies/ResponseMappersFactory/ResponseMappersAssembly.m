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
