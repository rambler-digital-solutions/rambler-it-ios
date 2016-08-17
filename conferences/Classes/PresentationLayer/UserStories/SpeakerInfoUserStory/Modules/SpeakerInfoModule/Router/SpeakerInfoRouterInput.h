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

@protocol SpeakerInfoRouterInput <NSObject>

/**
 @author Egor Tolstoy
 
 Method is used to open web browser module
 
 @param url Opening url
 */
- (void)openWebBrowserModuleWithUrl:(NSURL *)url;

/**
 @author Egor Tolstoy
 
 method is used to open Lecture Module
 
 @param lectureid Lecture identifier
 */
- (void)openLectureModuleWithLectureId:(NSString *)lectureId;

/**
 @author Artem Karpushin
 
 Method is used to initiate transition to the module of the event sharing
 
 @param activityItems Array of activity items for sharing
 */
- (void)openShareModuleWithActivityItems:(NSArray *)activityItems;

@end

