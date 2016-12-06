//
//  LectureViewModel.h
//  Conferences
//
//  Created by k.zinovyev on 06.12.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LectureMaterialViewModel.h"

@class SpeakerPlainObject;
@class TagPlainObject;

@interface LectureViewModel : NSObject

@property (nonatomic, copy) NSString *lectureDescription;
@property (nonatomic, copy) NSString *lectureId;
@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) NSArray<LectureMaterialViewModel *> *lectureMaterials;
@property (nonatomic, strong) SpeakerPlainObject *speaker;
@property (nonatomic, strong) NSSet<TagPlainObject *> *tags;


@end
