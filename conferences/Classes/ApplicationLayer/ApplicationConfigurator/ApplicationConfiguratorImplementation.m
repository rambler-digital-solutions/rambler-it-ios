//
//  ApplicationConfigurator.m
//  Conferences
//
//  Created by Karpushin Artem on 04/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "ApplicationConfiguratorImplementation.h"

#import <MagicalRecord/MagicalRecord.h>

static NSString * const kRCFCoreDataStoreName = @"Conference";

@implementation ApplicationConfiguratorImplementation

- (void)setupCoreDataStack {
    [MagicalRecord setupCoreDataStackWithStoreNamed:kRCFCoreDataStoreName];
}

@end
