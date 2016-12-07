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

#import "LectureInteractor.h"
#import <MagicalRecord/MagicalRecord.h>

#import "LectureInteractorOutput.h"
#import "LectureService.h"
#import "ROSPonsomizer.h"
#import "ShareUrlBuilder.h"
#import "YouTubeIdentifierDeriviator.h"
#import "EXTScope.h"
#import "LecturePlainObject.h"
#import "SpeakerPlainObject.h"
#import "LectureMaterialPlainObject.h"
#import "LectureMaterialsService.h"
#import "LectureMaterialModelObject.h"

@implementation LectureInteractor

#pragma mark - LectureInteractorInput

- (LecturePlainObject *)obtainLectureWithObjectId:(NSString *)objectId {
    id lectureManagedObject = [self.lectureService obtainLectureWithLectureId:objectId];
    LecturePlainObject *lecture = [self.ponsomizer convertObject:lectureManagedObject];
    return lecture;
}

- (NSArray *)obtainActivityItemsForLecture:(LecturePlainObject *)lecture {
    NSURL *shareUrl = [self.shareUrlBuilder buildShareUrlWithItemId:lecture.lectureId];
    NSArray *activityItems = @[shareUrl];
    return activityItems;
}

- (BOOL)checkIfVideoIsFromYouTube:(NSURL *)videoUrl {
    return [self.deriviator checkIfVideoIsFromYouTube:videoUrl];
}

- (NSString *)deriveVideoIdFromYouTubeUrl:(NSURL *)videoUrl {
    return [self.deriviator deriveIdentifierFromUrl:videoUrl];
}

- (void)downloadVideoToCacheWithLectureMaterial:(LectureMaterialPlainObject *)lectureMaterial {
    [self.lectureMaterialsService downloadToCacheLectureMaterial:lectureMaterial
                                                        delegate:self];
}
- (void)removeVideoFromCacheWithLectureMaterial:(LectureMaterialPlainObject *)lectureMaterial{
    [self.lectureMaterialsService removeFromCacheLectureMaterial:lectureMaterial
                                                      completion:^(NSError *error) {
                                                          LectureMaterialPlainObject *material = [self getLectureMaterialByLink:lectureMaterial.link];
                                                          [self.output didTriggerRemoveDownloadingLectureMaterialWithLectureMaterial:material];
                                                      }];
}

- (void)updateDownloadingDelegateWithLectureMaterials:(NSArray *)lectureMaterials {
    for (LectureMaterialPlainObject *lectureMaterial in lectureMaterials) {
        [self.lectureMaterialsService updateDelegate:self
                                  forLectureMaterial:lectureMaterial];
    }
}

#pragma mark - LectureMaterialDownloadingDelegate

- (void)didStartDownloadingLectureMaterialWithLink:(NSString *)link {
    LectureMaterialPlainObject *material = [self getLectureMaterialByLink:link];
    [self.output didTriggerStartDownloadingLectureMaterialWithLectureMaterial:material];
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    @weakify(self);
    dispatch_async(dispatch_get_main_queue(), ^{
        @strongify(self);
        LectureMaterialPlainObject *material = [self getLectureMaterialByLink:session.sessionDescription];
        [self.output didTriggerEndDownloadingLectureMaterialWithLectureMaterial:material];
    });
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    LectureMaterialPlainObject *material = [self getLectureMaterialByLink:session.sessionDescription];
    @weakify(self);
    dispatch_async(dispatch_get_main_queue(), ^{
        @strongify(self);
        CGFloat percent = totalBytesWritten * 100.0 / totalBytesExpectedToWrite;
        [self.output didTriggerDownloadingLectureMaterialWithLectureMaterial:material
                                                                     percent:percent];
    });
}

//
//- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler {
//    completionHandler(NSURLSessionAuthChallengeUseCredential, [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust]);
//}
//
//-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task willPerformHTTPRedirection:(NSHTTPURLResponse *)response newRequest:(NSURLRequest *)request completionHandler:(void (^)(NSURLRequest * _Nullable))completionHandler {
//    completionHandler(request);
//}

#pragma mark - Private methods

- (LectureMaterialPlainObject *)getLectureMaterialByLink:(NSString *)link {
    LectureMaterialModelObject *modelObject = [LectureMaterialModelObject MR_findFirstByAttribute:LectureMaterialModelObjectAttributes.link
                                                                                        withValue:link];
    LectureMaterialPlainObject *plainObject = [self.ponsomizer convertObject:modelObject];
    return plainObject;
}
@end
