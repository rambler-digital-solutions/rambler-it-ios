//
//  RCFParseResponseValidator.m
//  Conferences
//
//  Created by Egor Tolstoy on 04/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "ParseResponseValidator.h"

@implementation ParseResponseValidator

#pragma mark - RCFResponseValidator

- (NSError *)validateServerResponse:(id)response {
    NSError *resultError = nil;
    
    if(![super validateResponseIsDictionaryClass:response error:&resultError]) {
        return resultError;
    }
    
    return resultError;
}

@end
