//
//  LectureViewModelMapper.h
//  Conferences
//
//  Created by k.zinovyev on 06.12.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LectureViewModel;
@class LecturePlainObject;
@class LectureMaterialPlainObject;
@class LectureMaterialViewModel;

@interface LectureViewModelMapper : NSObject

- (LectureViewModel *)mapLectureViewModelFromLecturePlainObject:(LecturePlainObject *)lecture;
- (LectureMaterialPlainObject *)mapLectureMaterialPlainFromViewModel:(LectureMaterialViewModel *)lectureViewModel;

- (LectureMaterialViewModel *)updateMaterialInLectureViewModel:(LectureViewModel *)lecture
                                               lectureMaterial:(LectureMaterialPlainObject *)material
                                                 isDownloading:(NSNumber *)isDownloading
                                                       percent:(NSNumber *)percent;

@end
