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

#import <Foundation/Foundation.h>

@class LecturePlainObject;
@class LectureMaterialPlainObject;

@protocol LectureInteractorInput <NSObject>

/**
 @author Artem Karpushin
 
 Method is used to obtain Lecture object
 
 @param objectId LecturePlainObject object
 */
- (LecturePlainObject *)obtainLectureWithObjectId:(NSString *)objectId;

/**
 @author Artem Karpushin
 
 Method is used to obtain activity items for UIActivityController
 
 @param event EventPlainObject
 
 @return Activity items
 */
- (NSArray *)obtainActivityItemsForLecture:(LecturePlainObject *)lecture;

/**
 @author Egor Tolstoy
 
 Method performs a check for the video source
 
 @param videoUrl Video url
 
 @return YES/NO
 */
- (BOOL)checkIfVideoIsFromYouTube:(NSURL *)videoUrl;

/**
 @author Egor Tolstoy
 
 Method returns an identifier for youtube video
 
 @param videoUrl YouTube video URL
 
 @return YouTube video identifier
 */
- (NSString *)deriveVideoIdFromYouTubeUrl:(NSURL *)videoUrl;

- (void)downloadVideoToCacheWithLectureMaterial:(LectureMaterialPlainObject *)lectureMaterial;
- (void)removeVideoInCacheWithLectureMaterial:(LectureMaterialPlainObject *)lectureMaterial;

@end

