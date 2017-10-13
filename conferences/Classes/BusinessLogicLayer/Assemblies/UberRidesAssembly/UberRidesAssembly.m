// Copyright (c) 2016 RAMBLER&Co
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "UberRidesAssembly.h"

#import "LocationConstants.h"

#import <CoreLocation/CoreLocation.h>

static NSString *const kDropOffNickname = @"Rambler&Co";

@implementation UberRidesAssembly

- (UBSDKRideRequestViewRequestingBehavior *)requestBehaviorWithViewController:(UIViewController *)viewController {
    return [TyphoonDefinition withClass:[UBSDKRideRequestViewRequestingBehavior class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition useInitializer:@selector(initWithPresentingViewController:)
                                              parameters:^(TyphoonMethod *initializer) {
                                                  [initializer injectParameterWith:viewController];
                                              }];
                          }];
}

- (UBSDKRideParametersBuilder *)rideParametersBuilder {
    return [TyphoonDefinition withClass:[UBSDKRideParametersBuilder class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(dropoffLocation)
                                                    with:[self dropOffLocation]];
                              [definition injectProperty:@selector(dropoffNickname)
                                                    with:kDropOffNickname];
                          }];
}

- (CLLocation *)dropOffLocation {
    return [TyphoonDefinition withClass:[CLLocation class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition useInitializer:@selector(initWithLatitude:longitude:)
                                              parameters:^(TyphoonMethod *initializer) {
                                                  [initializer injectParameterWith:@(kRamblerLatitude)];
                                                  [initializer injectParameterWith:@(kRamblerLongitude)];
                                              }];
                          }];
}

@end
