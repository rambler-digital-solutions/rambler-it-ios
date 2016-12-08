//
//  UberRidesFactory.h
//  Conferences
//
//  Created by s.sarkisyan on 08.12.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UBSDKRideRequestButton;
@class UBSDKRideParameters;

@protocol UBSDKRideRequesting;

@interface UberRidesFactory : NSObject

/**
 @author Surik Sarkisyan
 
 The method returns a button for ride request
 
 @param uber ride parameters for button setup
 @param requestingBehavior
 
 @return UBSDKRideRequestButton
 */
- (UBSDKRideRequestButton *)createRideRequestButtonWithParameters:(UBSDKRideParameters *)parameters
                                              requestingBehavior:(id <UBSDKRideRequesting>)requestingBehavior;

@end
