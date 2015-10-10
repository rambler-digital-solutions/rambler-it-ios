//
//  ResponseMappersAssembly.h
//  Conferences
//
//  Created by Egor Tolstoy on 05/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <Typhoon/Typhoon.h>

#import "ResponseMappersFactory.h"

/**
 @author Egor Tolstoy
 
 The implementation of the ResponseMappersFactory protocol, based on TyphoonAssembly
 */
@interface ResponseMappersAssembly : TyphoonAssembly <ResponseMappersFactory>

@end
