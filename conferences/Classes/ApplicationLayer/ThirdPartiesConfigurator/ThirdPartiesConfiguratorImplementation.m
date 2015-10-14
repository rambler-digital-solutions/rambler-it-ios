//
//  ThirdPartiesConfiguratorImplementation.m
//  Conferences
//
//  Created by Karpushin Artem on 07/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "ThirdPartiesConfiguratorImplementation.h"

#import <Parse/Parse.h>

@implementation ThirdPartiesConfiguratorImplementation

#pragma mark - Public methods

- (void)configurate {
    [self setupParse];
}

#pragma mark - Private methods

- (void)setupParse {
    [Parse setApplicationId:@"nxZOr56yX2PzSLhgWUtpSx54WrtK1MYHqju94YUA"
                  clientKey:@"I1ZzQVAmCaFCLPLnqEnDBmN38dX9Hb2IDLwMyPJ4"];
}

@end
