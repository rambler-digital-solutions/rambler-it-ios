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

#import "RamblerLocationServiceImplementation.h"

#import "DirectionObject.h"

#import <CoreGraphics/CoreGraphics.h>

static NSString *kDirectionsFileName = @"directions";
static NSString *kDirectionsFileType = @"plist";

static CGFloat const kRamblerLatitude = 55.70288;
static CGFloat const kRamblerLongitude = 37.621011;

@implementation RamblerLocationServiceImplementation

- (NSArray<DirectionObject *> *)obtainDirections {
    NSDictionary *resource = [self.client loadResourceWithName:kDirectionsFileName
                                                          type:kDirectionsFileType];
    NSArray *result = [self.mapper mapResource:resource];
    return result;
}

- (CLLocationCoordinate2D)obtainRamblerCoordinates {
    CLLocationCoordinate2D coordinates = CLLocationCoordinate2DMake(kRamblerLatitude,
                                                                    kRamblerLongitude);
    return coordinates;
}

@end
