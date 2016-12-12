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

@implementation SpotlightImageIndexer

//resizer
//async

- (void)startIndexImageForSpotlight {
    for (id<ObjectImageIndexer> indexer in self.indexers) {
        NSArray *imageURLs = [indexer obtainImageURLs];
        NSArray *imageURLsForDownloading = [self filterDownloadedURLs:imageURLs];
        for (NSString *imageURL in imageURLsForDownloading) {
            NSURL *downloadURL = [NSURL URLWithString:imageURL];
            NSInteger options = SDWebImageLowPriority | SDWebImageContinueInBackground;
            [[SDWebImageManager sharedManager] downloadImageWithURL:downloadURL
                                                            options:options
                                                           progress:nil
                                                          completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *url) {
                [indexer updateModelsForImageURL:downloadURL];
            }];
        }
    }
}

- (NSArray *)filterDownloadedURLs:(NSArray *)imageURLs {
    SDImageCache *cache = [SDImageCache sharedImageCache];
    NSPredicate *predicateNull = [NSPredicate predicateWithFormat:@"SELF!=nil"];
    NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(NSString *imageURL, NSDictionary<NSString *,id> *bindings) {
        BOOL isImageNeedDownloading = ![cache diskImageExistsWithKey:imageURL];
        return isImageNeedDownloading;
    }];
    NSArray *filteredURLs = [imageURLs filteredArrayUsingPredicate:predicateNull];
    filteredURLs = [filteredURLs filteredArrayUsingPredicate:predicate];
    return filteredURLs;
}


@end
