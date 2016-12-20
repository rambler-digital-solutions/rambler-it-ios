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

#import "LectureImageIndexer.h"
#import <MagicalRecord/MagicalRecord.h>
#import "LectureModelObject.h"
#import "LectureMaterialModelObject.h"
#import "LectureMaterialType.h"
#import "VideoThumbnailGenerator.h"

@implementation LectureImageIndexer

- (NSArray<NSURL *> *)obtainImageURLs {
    NSArray *lecturesMaterials = [LectureMaterialModelObject MR_findByAttribute:LectureMaterialModelObjectAttributes.type
                                                                      withValue:@(LectureMaterialVideoType)];
    NSMutableArray *imageURLs = [[NSMutableArray alloc] init];
    
    NSArray *videoLinks = [lecturesMaterials valueForKey:LectureMaterialModelObjectAttributes.link];
    for (NSString *videoLink in videoLinks) {
        NSURL *videoURL = [NSURL URLWithString:videoLink];
        NSURL *imageURL = [self.videoThumbnailGenerator generateThumbnailWithVideoURL:videoURL];
        if (imageURL) {
            [imageURLs addObject:imageURL.absoluteString];
        }
    }
    return [imageURLs copy];
}

- (void)updateModelsForImageURL:(NSURL *)imageURL {
    NSManagedObjectContext *context = [NSManagedObjectContext MR_defaultContext];
    [context performBlockAndWait:^{
        LectureMaterialModelObject *modelObject = [LectureMaterialModelObject MR_findFirstByAttribute:LectureMaterialModelObjectAttributes.link
                                                                            withValue:imageURL.absoluteString
                                                                            inContext:context];
        LectureModelObject *lecture = modelObject.lecture;
        lecture.lectureId = lecture.lectureId;
        
        [context MR_saveToPersistentStoreAndWait];
    }];
}

@end
