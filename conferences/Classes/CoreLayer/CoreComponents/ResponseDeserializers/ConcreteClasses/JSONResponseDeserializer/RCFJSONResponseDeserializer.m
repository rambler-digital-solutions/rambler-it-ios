//
//  RCFJSONResponseDeserializer.m
//  Conferences
//
//  Created by Egor Tolstoy on 04/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "RCFJSONResponseDeserializer.h"

@implementation RCFJSONResponseDeserializer

#pragma mark - Initialization

- (instancetype)init {
    self = [super init];
    if (self) {
        NSMutableSet *contentTypes = [self.acceptableContentTypes mutableCopy];
        [contentTypes addObject: @"text/plain"];
        self.acceptableContentTypes = [contentTypes copy];
    }
    return self;
}

#pragma mark - RCFResponseDeserializer

- (void)deserializeServerResponse:(NSData *)responseData
                  completionBlock:(RCFResponseDeserializerCompletionBlock)block {
    NSError *error;
    NSDictionary *deserializedResponse = [super responseObjectForResponse:nil
                                                                     data:responseData
                                                                    error:&error];
    block(deserializedResponse, error);
}

#pragma mark - Debug Description

- (NSString *)debugDescription {
    return NSStringFromClass([self class]);
}

@end
