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

#import "LectureManagedObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface LectureManagedObject (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *favourite;
@property (nullable, nonatomic, retain) NSString *lectureDescription;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *slideLink;
@property (nullable, nonatomic, retain) NSString *videoLink;
@property (nullable, nonatomic, retain) NSNumber *lectureId;
@property (nullable, nonatomic, retain) EventManagedObject *event;
@property (nullable, nonatomic, retain) NSSet<LectureMaterialManagedObject *> *lectureMaterials;
@property (nullable, nonatomic, retain) NSSet<SpeakerManagedObject *> *speakers;

@end

@interface LectureManagedObject (CoreDataGeneratedAccessors)

- (void)addLectureMaterialsObject:(LectureMaterialManagedObject *)value;
- (void)removeLectureMaterialsObject:(LectureMaterialManagedObject *)value;
- (void)addLectureMaterials:(NSSet<LectureMaterialManagedObject *> *)values;
- (void)removeLectureMaterials:(NSSet<LectureMaterialManagedObject *> *)values;

- (void)addSpeakersObject:(SpeakerManagedObject *)value;
- (void)removeSpeakersObject:(SpeakerManagedObject *)value;
- (void)addSpeakers:(NSSet<SpeakerManagedObject *> *)values;
- (void)removeSpeakers:(NSSet<SpeakerManagedObject *> *)values;

@end

NS_ASSUME_NONNULL_END
