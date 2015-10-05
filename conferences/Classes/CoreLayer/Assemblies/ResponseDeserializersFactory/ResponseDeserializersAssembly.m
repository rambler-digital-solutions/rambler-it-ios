//
//  ResponseDeserializersAssembly.m
//  Conferences
//
//  Created by Egor Tolstoy on 05/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "ResponseDeserializersAssembly.h"

#import "RCFJSONResponseDeserializer.h"

@implementation ResponseDeserializersAssembly

#pragma mark - Option matcher

- (id<RCFResponseDeserializer>)deserializerWithType:(NSNumber *)type {
    return [TyphoonDefinition withOption:type matcher:^(TyphoonOptionMatcher *matcher) {
        [matcher caseEqual:@(ResponseDeserializationJSONType)
                       use:[self jsonResponseDeserializer]];
    }];
}

#pragma mark - Concrete definitions

- (id<RCFResponseDeserializer>)jsonResponseDeserializer {
    return [TyphoonDefinition withClass:[RCFJSONResponseDeserializer class]];
}

@end
