// Copyright (c) 2015 RAMBLER&Co
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

@protocol EventRouterInput <NSObject>

/**
 @author Artem Karpushin
 
 Method is used to initiate transition to the LectureModule
 
 @param lectureObjectId NSString lecture object id
 */
- (void)openLectureModuleWithLectureObjectId:(NSString *)lectureObjectId;

/**
 @author Egor Tolstoy
 
 Method is used to initiate transition to the EventModule
 
 @param eventId Event identifier
 */
- (void)openEventModuleWithEventId:(NSString *)eventId;

/**
 @author Artem Karpushin
 
 Method is used to initiate transition to the module of the event sharing
 
 @param activityItems Array of activity items for sharing
 */
- (void)openShareModuleWithActivityItems:(NSArray *)activityItems;

/**
 @author Vasyura Anastasiya
 
 Method is used to initiate transition to the speaker info module
 
 @param speakerId  Speaker identifier
 */
- (void)openSpeakerInfoModuleWithSpeakerId:(NSString *)speakerId;

@end

