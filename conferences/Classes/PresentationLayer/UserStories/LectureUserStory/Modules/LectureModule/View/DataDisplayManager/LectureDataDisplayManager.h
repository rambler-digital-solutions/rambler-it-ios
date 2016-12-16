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
#import "DataDisplayManager.h"

@class LectureViewModel;
@class LectureMaterialViewModel;
@protocol LectureCellObjectsBuilder;
@protocol LectureDataDisplayManagerDelegate;
@class LectureTableViewAnimator;

@interface LectureDataDisplayManager : NSObject <DataDisplayManager, UITableViewDelegate>

@property (nonatomic, strong) id<LectureCellObjectsBuilder> builderCellObjects;
@property (nonatomic, weak) id<LectureDataDisplayManagerDelegate> delegate;
@property (nonatomic, weak) IBOutlet LectureTableViewAnimator *animator;

/**
 @author Konstantin Zinovyev
 
 Method is used to configure data display manager with lecture view model
 
 @param lecture view model
 @param animator animator
*/
- (void)configureDataDisplayManagerWithLecture:(LectureViewModel *)lecture
                                      animator:(LectureTableViewAnimator *)animator;

/**
 @author Konstantin Zinovyev
 
 Method is used to update data display manager with lecture material view model
 
 @param material view model
 */
- (void)updateDataDisplayManagerWithLectureMaterial:(LectureMaterialViewModel *)material;

@end

@protocol LectureDataDisplayManagerDelegate <NSObject>

/**
 @author Egor Tolstoy
 
 Method tells a delegate that a video cell was tapped
 
 @param videoUrl Video URL
 */
- (void)didTapVideoRecordCellWithVideoMaterial:(LectureMaterialViewModel *)videoMaterial;

/**
 @author Egor Tolstoy
 
 Method tells a delegate that a material cell was tapped
 
 @param videoUrl Material URL
 */
- (void)didTapMaterialCellWithUrl:(NSURL *)materialUrl;

@end
