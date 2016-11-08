//
//  MessagesUserActivityFactory.m
//  Conferences
//
//  Created by Trishina Ekaterina on 28/10/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import "MessagesUserActivityFactory.h"
#import <CoreSpotlight/CoreSpotlight.h>
#import "NSArray+NSURLQueryItem.h"
#import "MessagesConstants.h"

@implementation MessagesUserActivityFactory

- (NSUserActivity *)createUserActivityFromURL:(NSURL *)url {
    NSURLComponents *urlComponents = [NSURLComponents componentsWithString:url.absoluteString];
    if (![urlComponents.scheme isEqualToString:RCFURLScheme]) {
        return nil;
    }
    NSArray<NSURLQueryItem *> *queryItems = urlComponents.queryItems;
    NSString *type = [queryItems queryValueForKey:RCFURLQueryItemType];
    NSUserActivity *activity = [[NSUserActivity alloc] initWithActivityType:type];
    activity.userInfo = @{CSSearchableItemActivityIdentifier : [queryItems queryValueForKey:RCFURLQueryItemId]};
    return activity;
}

@end
