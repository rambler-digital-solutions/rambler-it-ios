// Copyright (c) 2016 RAMBLER&Co
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

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
