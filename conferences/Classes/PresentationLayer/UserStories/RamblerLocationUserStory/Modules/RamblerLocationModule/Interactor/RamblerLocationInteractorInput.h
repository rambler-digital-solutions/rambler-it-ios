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

#import <Foundation/Foundation.h>

@class DirectionObject;
@class CLLocation;
@class UBSDKRideParameters;

@protocol RamblerLocationInteractorInput <NSObject>

/**
 @author Egor Tolstoy
 
 The method returns all of the available directions to Rambler&Co HQ
 
 @return NSArray <DirectionObject *>
 */
- (NSArray <DirectionObject *> *)obtainDirections;

/**
 @author Egor Tolstoy
 
 The method returns an url constructed to open Apple Maps with Rambler location
 
 @return NSURL
 */
- (NSURL *)obtainRamblerLocationUrl;

/**
 @author Surik Sarkisyan
 
 The method returns defaul Uber Ride Parameters
 
 @return UBSDKRideParameters
 */
- (UBSDKRideParameters *)obtainDefaultParameters;

/**
 @author Surik Sarkisyan
 
 The method tries to get user current location and update ride info if it possible.
 */
- (void)performRideInfoForUserCurrentLocationIfPossible;

@end

