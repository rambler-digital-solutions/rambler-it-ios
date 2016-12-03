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
#import "LectureInteractorInput.h"

@protocol LectureService;
@protocol ROSPonsomizer;
@protocol LectureInteractorOutput;
@protocol ShareUrlBuilder;
@protocol LectureMaterialsService;
@class YouTubeIdentifierDeriviator;
@class VideoMaterialDownloadingStatesStorage;

@interface LectureInteractor : NSObject <LectureInteractorInput, NSURLSessionDownloadDelegate>

@property (nonatomic, strong) id<LectureService> lectureService;
@property (nonatomic, strong) id<LectureMaterialsService> lectureMaterialsService;
@property (nonatomic, strong) id<ROSPonsomizer> ponsomizer;
@property (nonatomic, strong) id<ShareUrlBuilder> shareUrlBuilder;
@property (nonatomic, strong) YouTubeIdentifierDeriviator *deriviator;
@property (nonatomic, weak) id<LectureInteractorOutput> output;
@property (nonatomic, strong) VideoMaterialDownloadingStatesStorage *statesStorage;

@end

