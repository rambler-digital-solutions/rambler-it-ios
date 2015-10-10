//
//  ResponseDeserializersAssembly.m
//  Conferences
//
//  Created by Egor Tolstoy on 05/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "ResponseDeserializersAssembly.h"

#import "JSONResponseDeserializer.h"

@implementation ResponseDeserializersAssembly

#pragma mark - Option matcher

- (id<ResponseDeserializer>)deserializerWithType:(NSNumber *)type {
    return [TyphoonDefinition withOption:type matcher:^(TyphoonOptionMatcher *matcher) {
        [matcher caseEqual:@(ResponseDeserializationJSONType)
                       use:[self jsonResponseDeserializer]];
    }];
}

#pragma mark - Concrete definitions

- (id<ResponseDeserializer>)jsonResponseDeserializer {
    return [TyphoonDefinition withClass:[JSONResponseDeserializer class]];
}

@end
