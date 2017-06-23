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
#import "LectureMaterialCacheOperationType.h"

@class LectureViewModel;
@class LecturePlainObject;
@class LectureMaterialPlainObject;
@class LectureMaterialViewModel;

@interface LectureViewModelMapper : NSObject

/**
 @author Konstantin Zinovyev

 The method is used to map Lecture plain object to Lecture view model
 
 @param lecture     plain object
 @return lecture    view model object
 */
- (LectureViewModel *)mapLectureViewModelFromLecturePlainObject:(LecturePlainObject *)lecture;

/**
 @author Konstantin Zinovyev
 
 The methods is used to update Lecture view model with lecture material object
 
 @param lecture         view model object
 @param lecture         material plain object
 @param isDownloading   is downloading lecture material
 @param percent         percentage download of the file
 
 @return lecture view model object
 */
- (LectureMaterialViewModel *)updateMaterialInLectureViewModel:(LectureViewModel *)lecture
                                               lectureMaterial:(LectureMaterialPlainObject *)material
                                                 operationType:(LectureMaterialCacheOperationType)operationType
                                                       percent:(NSNumber *)percent;

@end
