// Copyright (c) 2015 RAMBLER&Co
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

#import "RamblerLocationInteractor.h"

#import "RamblerLocationInteractorOutput.h"

#import "MapLinkBuilder.h"

#import "LocationService.h"

@implementation RamblerLocationInteractor

#pragma mark - RamblerLocationInteractorInput

- (NSArray<DirectionObject *> *)obtainDirections {
    NSArray *directions = [self.ramblerLocationService obtainDirections];
    return directions;
}

- (NSURL *)obtainRamblerLocationUrl {
    CLLocationCoordinate2D coordinates = [self.ramblerLocationService obtainRamblerCoordinates];
    NSURL *mapUrl = [self.mapLinkBuilder buildUrlWithCoordinates:coordinates];
    return mapUrl;
}

- (void)getRideInfoForUserCurrentLocationIfPossible {
    [self.locationService getUserLocation];
}

- (UBSDKRideParameters *)getDefaultParameters {
    return [self.builder build];
}

#pragma mark - LocationServiceOutput
- (void)didUpdateLocation:(CLLocation *)location {
    [self.builder setPickupLocation:location];
    [self fetchCheapestProductWithPickupLocation:location];
}

#pragma mark - Private methods
- (void)fetchCheapestProductWithPickupLocation:(CLLocation *)location {
    UBSDKRidesClient *ridesClient = [UBSDKRidesClient new];
    [ridesClient fetchCheapestProductWithPickupLocation:location completion:^(UBSDKUberProduct* _Nullable product, UBSDKResponse* _Nullable response) {
        if (product) {
            self.builder = [self.builder setProductID:product.productID];
            
            UBSDKRideParameters *parameters = [self.builder build];
            [self.output rideParametersDidLoad:parameters];
        }
    }];
}

@end
