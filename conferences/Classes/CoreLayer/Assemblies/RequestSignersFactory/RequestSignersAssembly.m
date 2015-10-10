//
//  RequestSignersAssembly.m
//  Conferences
//
//  Created by Egor Tolstoy on 05/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "RequestSignersAssembly.h"

#import "ParseRequestSigner.h"

static  NSString *const kConfigFileName  = @"Conferences.Parse.plist";
static  NSString *const kParseApplicationIdKey = @"ApplicationId";
static  NSString *const kParseApiKey = @"APIKey";

@implementation RequestSignersAssembly

#pragma mark - Option matcher

- (id<RequestSigner>)requestSignerWithType:(NSNumber *)type {
    return [TyphoonDefinition withOption:type matcher:^(TyphoonOptionMatcher *matcher) {
        [matcher caseEqual:@(RequestSigningParseType)
                       use:[self parseRequestSigner]];
    }];
}

#pragma mark - Concrete definitions

- (id<RequestSigner>)parseRequestSigner {
    return [TyphoonDefinition withClass:[ParseRequestSigner class] configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(initWithApplicationId:apiKey:) parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:TyphoonConfig(kParseApplicationIdKey)];
            [initializer injectParameterWith:TyphoonConfig(kParseApiKey)];
        }];
    }];
}

#pragma mark - Config

- (id)configurer {
    return [TyphoonDefinition configDefinitionWithName:kConfigFileName];
}

@end
