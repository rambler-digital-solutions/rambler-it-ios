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
    return [TyphoonDefinition withConfigName:kConfigFileName];
}

@end
