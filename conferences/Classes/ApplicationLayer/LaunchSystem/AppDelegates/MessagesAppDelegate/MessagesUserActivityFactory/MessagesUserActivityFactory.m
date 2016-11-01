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

@implementation MessagesUserActivityFactory

- (NSUserActivity *)createUserActivityFromURL:(NSURL *)url {
    NSURLComponents *urlComponents = [NSURLComponents componentsWithString:url.absoluteString];
    if (![urlComponents.scheme isEqualToString:@"ramblerconferences"]) {
        return nil;
    }
    NSArray<NSURLQueryItem *> *queryItems = urlComponents.queryItems;
    NSString *type = [queryItems queryValueForKey:@"type"];
    NSUserActivity *activity = [[NSUserActivity alloc] initWithActivityType:type];
    activity.userInfo = @{CSSearchableItemActivityIdentifier : [queryItems queryValueForKey:@"id"]};
    return activity;
}

@end
