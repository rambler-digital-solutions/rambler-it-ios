//
//  EventImageIndexer.m
//  Conferences
//
//  Created by Konstantin Zinovyev on 12.12.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import "EventImageIndexer.h"
#import "EventModelObject.h"
#import <MagicalRecord/MagicalRecord.h>

@implementation EventImageIndexer

- (NSArray<NSURL *> *)obtainImageURLs {
    NSArray *events = [EventModelObject MR_findAll];
    NSArray *imageURLs = [events valueForKey:EventModelObjectAttributes.imageUrl];
    return imageURLs;
}

- (void)updateModelsForImageURL:(NSURL *)imageURL {
    NSManagedObjectContext *context = [NSManagedObjectContext MR_defaultContext];
    [context performBlockAndWait:^{
        EventModelObject *modelObject = [EventModelObject MR_findFirstByAttribute:EventModelObjectAttributes.imageUrl
                                                                        withValue:imageURL.absoluteString
                                                                        inContext:context];
        modelObject.imageUrl = modelObject.imageUrl;
        [context MR_saveToPersistentStoreAndWait];
    }];
}

@end
