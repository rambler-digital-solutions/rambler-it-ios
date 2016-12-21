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
#import <CoreSpotlight/CoreSpotlight.h>
#import "SpeakerObjectIndexer.h"
#import "SpotlightImageModel.h"

@implementation SpeakerImageIndexer

- (NSArray<SpotlightImageModel *> *)obtainImageModels {
    NSArray *speakers = [SpeakerModelObject MR_findAll];
    NSMutableArray *imageModels = [NSMutableArray new];
    for (SpeakerModelObject *speaker in speakers) {
        if (speaker.imageUrl.length > 0 && speaker.speakerId.length > 0) {
            SpotlightImageModel *model = [[SpotlightImageModel alloc] initWithEntityId:speaker.speakerId
                                                                             imageLink:speaker.imageUrl];
            [imageModels addObject:model];
        }
    }
    return [imageModels copy];
}

- (void)updateModelsForEntityIdentifier:(NSString *)identifier {
    SpeakerModelObject *modelObject = [SpeakerModelObject MR_findFirstByAttribute:SpeakerModelObjectAttributes.speakerId
                                                                        withValue:identifier];
    CSSearchableItem *searchableItem = [self.indexer searchableItemForObject:modelObject];
    [self.searchableIndex indexSearchableItems:@[searchableItem]
                             completionHandler:nil];
}

@end
