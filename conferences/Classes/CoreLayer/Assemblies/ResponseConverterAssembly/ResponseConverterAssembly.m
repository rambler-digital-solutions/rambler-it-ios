//
//  ResponseConverterAssembly.m
//  Conferences
//
//  Created by k.zinovyev on 15.08.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import "ResponseConverterAssembly.h"
#import "ResponseConverterImplementation.h"
#import "ResultsResponseObjectFormatter.h"

@implementation ResponseConverterAssembly

- (id <ResponseConverter>)converterResponse {
    return [TyphoonDefinition withClass:[ResponseConverterImplementation class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(responseFormatter)
                                                    with:[self formatter]];
                          }];
}

- (id<ResponseObjectFormatter>)formatter {
    return [TyphoonDefinition withClass:[ResultsResponseObjectFormatter class]];
}

@end
