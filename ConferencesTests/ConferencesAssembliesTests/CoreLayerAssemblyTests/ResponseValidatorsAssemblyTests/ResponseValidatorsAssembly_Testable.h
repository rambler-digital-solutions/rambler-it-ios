//
//  ResponseValidatorsAssembly_Testable.h
//  Conferences
//
//  Created by Karpushin Artem on 16/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "ResponseValidatorsAssembly.h"

@protocol ResponseValidator;

@interface ResponseValidatorsAssembly ()

- (id<ResponseValidator>)parseResponseValidator;

@end
