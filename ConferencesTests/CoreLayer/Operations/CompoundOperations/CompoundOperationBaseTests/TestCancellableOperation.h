//
//  TestCancellableOperation.h
//  Conferences
//
//  Created by Egor Tolstoy on 01/09/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ChainableOperation.h"

@interface TestCancellableOperation : NSOperation <ChainableOperation>

@end
