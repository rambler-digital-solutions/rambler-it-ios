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

@class LectureMaterialViewModel;

@protocol LectureViewOutput <NSObject>

/**
 @author Artem Karpushin
 
 Method is used to inform presenter that view needs to be configured
 */
- (void)setupView;

/**
 @author Egor Tolstoy
 
 Method is used to inform presenter that a video preview was tapped
 
 @param videoUrl The URL of the video
 */
- (void)didTapVideoPreviewWithVideoMaterial:(LectureMaterialViewModel *)videoMaterial;

/**
 @author Egor Tolstoy
 
 Method is used to inform presenter that a material was tapped
 
 @param videoUrl The URL of the video
 */
- (void)didTapMaterialWithUrl:(NSURL *)materialUrl;

/**
 @author Egor Tolstoy
 
 Method is used to inform presenter that a speaker was tapped
 
 @param videoUrl The URL of the video
 */
- (void)didTapSpeakerWithId:(NSString *)speakerId;

/**
 @author Artem Karpushin
 
 Method is used to inform presenter that share button was tapped
 */
- (void)didTapShareButton;

/**
 @author Artem Karpushin
 
 Method is used to inform presenter that view will appear
 */
- (void)didTriggerViewWillAppear;

@end

