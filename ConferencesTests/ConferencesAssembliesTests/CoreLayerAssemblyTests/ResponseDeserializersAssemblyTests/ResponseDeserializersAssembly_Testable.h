//
//  ResponseDeserializersAssembly_Testable.h
//  Conferences
//
//  Created by Karpushin Artem on 16/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "ResponseDeserializersAssembly.h"

@protocol ResponseDeserializer;

@interface ResponseDeserializersAssembly ()

- (id<ResponseDeserializer>)jsonResponseDeserializer;

@end
