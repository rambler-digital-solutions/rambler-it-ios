//
//  UberRidesModalTestableObject.m
//  Conferences
//
//  Created by s.sarkisyan on 12.12.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import "UberRidesModalTestableObject.h"
#import "TestableObjectWithDelegate.h"

@implementation UberRidesModalTestableObject

- (id)rideRequestViewController {
    return [TestableObjectWithDelegate new];
}

@end
