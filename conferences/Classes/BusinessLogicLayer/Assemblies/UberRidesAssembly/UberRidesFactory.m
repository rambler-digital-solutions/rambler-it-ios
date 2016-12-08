//
//  UberRidesFactory.m
//  Conferences
//
//  Created by s.sarkisyan on 08.12.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import "UberRidesFactory.h"
#import <UberRides/UberRides.h>

@implementation UberRidesFactory

- (UBSDKRideRequestButton *)createRideRequestButtonWithParameters:(UBSDKRideParameters *)parameters
                                              requestingBehavior:(id <UBSDKRideRequesting>)requestingBehavior {
    return [[UBSDKRideRequestButton alloc] initWithRideParameters:parameters
                                               requestingBehavior:requestingBehavior];
}

@end
