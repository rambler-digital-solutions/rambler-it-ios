//
//  ResponseDeserializersAssembly.h
//  Conferences
//
//  Created by Egor Tolstoy on 05/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <Typhoon/Typhoon.h>

#import "ResponseDeserializersFactory.h"

/**
 @author Egor Tolstoy
 
 The implementation of the ResponseDeserializersFactory protocol, based on TyphoonAssembly
 */
@interface ResponseDeserializersAssembly : TyphoonAssembly <ResponseDeserializersFactory>

@end
