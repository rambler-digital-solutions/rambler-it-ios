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
