//
//  SpeakerImageIndexer.m
//  Conferences
//
//  Created by Konstantin Zinovyev on 12.12.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import "SpeakerImageIndexer.h"
#import "SpeakerModelObject.h"
#import "LectureModelObject.h"
#import <MagicalRecord/MagicalRecord.h>

@implementation SpeakerImageIndexer

- (NSArray<NSURL *> *)obtainImageURLs {
    NSArray *speakers = [SpeakerModelObject MR_findAll];
    NSArray *imageURLs = [speakers valueForKey:SpeakerModelObjectAttributes.imageUrl];
    return imageURLs;
}

- (void)updateModelsForImageURL:(NSURL *)imageURL {
    NSManagedObjectContext *context = [NSManagedObjectContext MR_defaultContext];
    [context performBlockAndWait:^{
        SpeakerModelObject *modelObject = [SpeakerModelObject MR_findFirstByAttribute:SpeakerModelObjectAttributes.imageUrl
                                                                            withValue:imageURL.absoluteString
                                                                            inContext:context];
        modelObject.imageUrl = modelObject.imageUrl;
        [context MR_saveToPersistentStoreAndWait];
    }];
}

@end
