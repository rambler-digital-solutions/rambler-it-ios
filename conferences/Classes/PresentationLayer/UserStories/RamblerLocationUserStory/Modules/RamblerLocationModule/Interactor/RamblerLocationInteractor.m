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

#import "EXTScope.h"
#import "MapLinkBuilder.h"
#import "LocationService.h"
#import "LocalizedStrings.h"
#import "ApplicationConstants.h"

#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import <Contacts/Contacts.h>

@implementation RamblerLocationInteractor

#pragma mark - RamblerLocationInteractorInput

- (NSArray<DirectionObject *> *)obtainDirections {
    return [self.ramblerLocationService obtainDirections];;
}

- (NSURL *)obtainRamblerLocationUrl {
    CLLocationCoordinate2D coordinates = [self.ramblerLocationService obtainRamblerCoordinates];
    NSURL *mapUrl = [self.mapLinkBuilder buildUrlWithCoordinates:coordinates];
    return mapUrl;
}

- (void)performRideInfoForUserCurrentLocationIfPossible {
    [self.locationService obtainUserLocation];
}

- (UBSDKRideParameters *)obtainDefaultParameters {
    return [self.builder build];
}

- (NSUserActivity *)registerUserActivity {
    NSUserActivity *activity = [[NSUserActivity alloc] initWithActivityType:kLocationUserActivityType];
    activity.title = RCLocalize(kRamblerOfficeName);
    CLLocationCoordinate2D coordinates = [self.ramblerLocationService obtainRamblerCoordinates];
    MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:coordinates
                                                   addressDictionary: @{CNPostalAddressStreetKey : RCLocalize(kRamblerOfficeName)}];
    if (IS_IOS_10_OR_LATER) {
        activity.mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
    }
    [activity becomeCurrent];
    
    return activity;
}

- (void)unregisterUserActivity:(NSUserActivity *)activity {
    [activity resignCurrent];
}

#pragma mark - LocationServiceOutput

- (void)locationService:(id<LocationService>)locationService didUpdateLocation:(CLLocation *)location {
    [self.builder setPickupLocation:location];
    [self fetchCheapestProductWithPickupLocation:location];
}

#pragma mark - Private methods

- (void)fetchCheapestProductWithPickupLocation:(CLLocation *)location {
    @weakify(self);
    [self.ridesClient fetchProductsWithPickupLocation:location
                                           completion:^(NSArray<UBSDKProduct *> *products, UBSDKResponse * response) {
                                               @strongify(self);
                                               UBSDKProduct *cheapestProduct = [self cheapestProductInProducts:products];
                                               self.builder.productID = cheapestProduct.productID;
                                               
                                               UBSDKRideParameters *parameters = [self.builder build];
                                               [self.output rideParametersDidLoad:parameters];
                                           }];
}

- (UBSDKProduct *)cheapestProductInProducts:(NSArray *)products {
    UBSDKProduct *cheapestProduct = products.firstObject;
    for (UBSDKProduct *product in products) {
        if (product.priceDetails.costPerDistance < cheapestProduct.priceDetails.costPerDistance) {
            cheapestProduct = product;
        }
    }
    return cheapestProduct;
}

@end
