//
//  TransfromJSONImplementation.h
//  Conferences
//
//  Created by k.zinovyev on 15.08.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseConverter.h"
#import "ResponseObjectFormatter.h"

@interface ResponseConverterImplementation : NSObject <ResponseConverter>

@property (strong, nonatomic) id<ResponseObjectFormatter> responseFormatter;

@end
