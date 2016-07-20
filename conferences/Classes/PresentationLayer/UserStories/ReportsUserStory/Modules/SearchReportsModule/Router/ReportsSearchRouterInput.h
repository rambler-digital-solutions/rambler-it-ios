//
//  ReportsSearchRouterInput.h
//  Conferences
//
//  Created by k.zinovyev on 19.07.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ReportsSearchRouterInput <NSObject>

- (void)openEventModuleWithEventObjectId:(NSString *)objectId;

@end