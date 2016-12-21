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
#import <CoreSpotlight/CoreSpotlight.h>
#import "SpotlightImageModel.h"
#import "EventObjectIndexer.h"

@implementation EventImageIndexer

- (NSArray<SpotlightImageModel *> *)obtainImageModels {
    NSArray *events = [EventModelObject MR_findAll];
    NSMutableArray *imageModels = [NSMutableArray new];
    for (EventModelObject *event in events) {
        if (event.imageUrl.length > 0 && event.eventId.length > 0) {
            SpotlightImageModel *model = [[SpotlightImageModel alloc] initWithEntityId:event.eventId
                                                                             imageLink:event.imageUrl];
            [imageModels addObject:model];
        }
    }
    return [imageModels copy];
}

- (void)updateModelsForEntityIdentifier:(NSString *)identifier {
    EventModelObject *modelObject = [EventModelObject MR_findFirstByAttribute:EventModelObjectAttributes.eventId
                                                                    withValue:identifier];
    CSSearchableItem *searchableItem = [self.indexer searchableItemForObject:modelObject];
    [self.searchableIndex indexSearchableItems:@[searchableItem]
                             completionHandler:nil];
}
@end
