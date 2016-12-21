//
//  SpotlightImageIndexer.m
//  Conferences
//
//  Created by Konstantin Zinovyev on 10.12.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import "SpotlightImageIndexer.h"
#import <MagicalRecord/MagicalRecord.h>
#import <SDWebImage/SDImageCache.h>
#import <SDWebImage/SDWebImageManager.h>
#import "SpeakerModelObject.h"
#import "SpotlightEntityImageIndexer.h"
#import "SpotlightImageModel.h"

@implementation SpotlightImageIndexer

- (void)startIndexImageForSpotlight {
    for (id<SpotlightEntityImageIndexer> indexer in self.indexers) {
        NSArray<SpotlightImageModel *> *imageModels = [indexer obtainImageModels];
        NSArray<SpotlightImageModel *> *imageURLsForDownloading = [self filterDownloadedURLs:imageModels];
        for (SpotlightImageModel *model in imageURLsForDownloading) {
            NSURL *downloadURL = [NSURL URLWithString:model.imageLink];
            NSInteger options = SDWebImageLowPriority | SDWebImageContinueInBackground | SDWebImageRefreshCached;
            [self.imageManager downloadImageWithURL:downloadURL
                                            options:options
                                           progress:nil
                                          completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *url) {
                [indexer updateModelsForEntityIdentifier:model.entityId];
            }];
        }
    }
}

- (NSArray<SpotlightImageModel *> *)filterDownloadedURLs:(NSArray<SpotlightImageModel *> *)imageModels {
    NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(SpotlightImageModel *imageModel, NSDictionary<NSString *,id> *bindings) {
        BOOL isImageNeedDownloading = ![self.imageCache diskImageExistsWithKey:imageModel.imageLink];
        return isImageNeedDownloading;
    }];
    NSArray<SpotlightImageModel *> *filteredModels = [imageModels filteredArrayUsingPredicate:predicate];
    return filteredModels;
}

@end
