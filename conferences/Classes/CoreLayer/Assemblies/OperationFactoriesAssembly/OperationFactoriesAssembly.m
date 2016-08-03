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

#import "OperationFactoriesAssembly.h"

#import "NetworkCompoundOperationBuilder.h"
#import "OperationChainer.h"
#import "EventListQueryTransformer.h"

#import "EventListOperationFactory.h"

static NSString *const kLastModifiedDateFormat = @"EE, d MMM yyyy HH:mm:ss ZZZ";

@implementation OperationFactoriesAssembly

#pragma mark - Operation factories

- (EventListOperationFactory *)eventListOperationFactory {
    return [TyphoonDefinition withClass:[EventListOperationFactory class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition useInitializer:@selector(initWithBuilder:queryTransformer:)
                                              parameters:^(TyphoonMethod *initializer) {
                                                  [initializer injectParameterWith:[self networkOperationBuilder]];
                                                  [initializer injectParameterWith:[self eventListQueryTransformer]];
                                              }];
                          }];
}

- (EventListQueryTransformer *)eventListQueryTransformer {
    return [TyphoonDefinition withClass:[EventListQueryTransformer class]];
}

#pragma mark - Builders

- (NetworkCompoundOperationBuilder *)networkOperationBuilder {
    return [TyphoonDefinition withClass:[NetworkCompoundOperationBuilder class] configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(initWithOperationChainer:)
                        parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:[self operationChainer]];
        }];
        
        [definition injectProperty:@selector(requestConfiguratorsFactory)
                              with:self.requestConfiguratorsFactory];
        [definition injectProperty:@selector(requestSignersFactory)
                              with:self.requestSignersFactory];
        [definition injectProperty:@selector(networkClientsFactory)
                              with:self.networkClientsFactory];
        [definition injectProperty:@selector(responseDeserializersFactory)
                              with:self.responseDeserializersFactory];
        [definition injectProperty:@selector(responseValidatorsFactory)
                              with:self.responseValidatorsFactory];
        [definition injectProperty:@selector(responseMappersFactory)
                              with:self.responseMappersFactory];
        [definition injectProperty:@selector(lastModifiedDateFormatter)
                              with:[self lastModifiedDateFormatter]];
    }];
}

#pragma mark - Others

- (OperationChainer *)operationChainer {
    return [TyphoonDefinition withClass:[OperationChainer class]];
}

- (NSDateFormatter *)lastModifiedDateFormatter {
    return [TyphoonDefinition withClass:[NSDateFormatter class]
                          configuration:^(TyphoonDefinition *definition) {
                              definition.scope = TyphoonScopeSingleton;
                              [definition injectMethod:@selector(setDateFormat:)
                                            parameters:^(TyphoonMethod *method) {
                                                [method injectParameterWith:kLastModifiedDateFormat];
                                            }];
                          }];
}

@end
