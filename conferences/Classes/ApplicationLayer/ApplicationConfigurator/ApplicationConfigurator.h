//
//  ApplicationConfigurator.h
//  Conferences
//
//  Created by Karpushin Artem on 04/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ApplicationConfigurator <NSObject>

/**
 @author Artem Karpushin
 
 Method is used to setup CoreData stack
 */
- (void)setupCoreDataStack;

@end
