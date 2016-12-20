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
#import "ObjectImageIndexer.h"
#import "SpotlightImageModel.h"

@implementation SpotlightImageIndexer

//resizer
//async

- (void)startIndexImageForSpotlight {
    for (id<ObjectImageIndexer> indexer in self.indexers) {
        NSArray<SpotlightImageModel *> *imageModels = [indexer obtainImageURLs];
//        NSArray *imageURLsForDownloading = [self filterDownloadedURLs:imageURLs];
        for (SpotlightImageModel *model in imageModels) {
            NSURL *downloadURL = [NSURL URLWithString:model.imageLink];
            NSInteger options = SDWebImageLowPriority | SDWebImageContinueInBackground | SDWebImageRefreshCached;
            [[SDWebImageManager sharedManager] downloadImageWithURL:downloadURL
                                                            options:options
                                                           progress:nil
                                                          completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *url) {
                [indexer updateModelsForEntityIdentifier:model.entityId];
            }];
        }
    }
}

//- (NSArray *)filterDownloadedURLs:(NSArray *)imageURLs {
//    SDImageCache *cache = [SDImageCache sharedImageCache];
//    NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(NSString *imageURL, NSDictionary<NSString *,id> *bindings) {
//        BOOL isImageNeedDownloading = ![cache diskImageExistsWithKey:imageURL];
//        return isImageNeedDownloading;
//    }];
//    filteredURLs = [filteredURLs filteredArrayUsingPredicate:predicate];
//    return filteredURLs;
//}


@end
