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
#import "LectureMaterialsHandler.h"

@protocol LectureMaterialDownloadingDelegate;

typedef void (^LectureMaterialsCompletionBlock)(NSError *error);

/**
 @author Artem Karpushin
 
 The service is designed to download / remove from cache LectureMaterials objects
 */
@protocol LectureMaterialsService <NSObject>

/**
 @author Konstantin Zinovyev

 Method is used to start downloading data for Lecture Material with delegate
 
 @param lectureMaterialId Identifier Lecture Material object
 @param delegate          Object that obtain message about downloading
 */
- (void)downloadToCacheLectureMaterialId:(NSString *)lectureMaterialId
                                delegate:(id<LectureMaterialDownloadingDelegate>)delegate;

/**
 @author Konstantin Zinovyev

 Method is used to remove data for Lecture Material
 
 @param lectureMaterialId Identifier Lecture Material object
 @param completionBlock   Block that runs after removing data
 */
- (void)removeFromCacheLectureMaterialId:(NSString *)lectureMaterialId
                            completion:(LectureMaterialsCompletionBlock)completionBlock;

/**
 @author Konstantin Zinovyev

 Method is used to update delegate for Lecture Material object
 
 @param delegate          Object that obtain message about downloading
 @param lectureMaterialId Identifier Lecture Material object
 */
- (void)updateDelegate:(id<LectureMaterialDownloadingDelegate>)delegate
  forLectureMaterialId:(NSString *)lectureMaterialId;

@end
