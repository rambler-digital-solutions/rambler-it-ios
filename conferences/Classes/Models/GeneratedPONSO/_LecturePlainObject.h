//
//  _Lecture.h
//
//
// DO NOT EDIT. This file is machine-generated and constantly overwritten.
//

#import <Foundation/Foundation.h>

@class EventPlainObject;
@class LectureMaterialPlainObject;
@class SpeakerPlainObject;
@class TagPlainObject;

@interface _LecturePlainObject : NSObject <NSCoding, NSCopying>

@property (nonatomic, copy, readwrite) NSNumber *favourite;
@property (nonatomic, copy, readwrite) NSString *lectureDescription;
@property (nonatomic, copy, readwrite) NSString *lectureId;
@property (nonatomic, copy, readwrite) NSString *name;

@property (nonatomic, copy, readwrite) EventPlainObject *event;

@property (nonatomic, copy, readwrite) NSSet<LectureMaterialPlainObject *> *lectureMaterials;

@property (nonatomic, copy, readwrite) SpeakerPlainObject *speaker;

@property (nonatomic, copy, readwrite) NSSet<TagPlainObject *> *tags;

@end
