//
//  UberAssembly.m
//  Conferences
//
//  Created by a.yakimenko on 18.10.2017.
//  Copyright © 2017 Rambler. All rights reserved.
//

#import "UberAssembly.h"
#import <UberRides/UberRides.h>
#import "UberRidesAppDelegate.h"

@implementation UberAssembly

- (UberRidesAppDelegate *)uberRidesAppDelegate {
    return [TyphoonDefinition withClass:[UberRidesAppDelegate class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(configuration)
                                                    with:[self configuration]];
                              [definition injectProperty:@selector(ridesAppDelegate)
                                                    with:[self ridesAppDelegate]];
                          }];
}

- (UBSDKConfiguration *)configuration {
    return [TyphoonDefinition withClass:[UBSDKConfiguration class]];
}

- (UBSDKRidesAppDelegate *)ridesAppDelegate {
    return [TyphoonDefinition withClass:[UBSDKRidesAppDelegate class]];
}

@end
