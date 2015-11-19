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
//
// Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
// to delete and recreate this implementation file for your updated model.
//

#import "Lecture.h"

NS_ASSUME_NONNULL_BEGIN

@interface Lecture (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *favourite;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *orderID;
@property (nullable, nonatomic, retain) NSString *slideLink;
@property (nullable, nonatomic, retain) NSString *lectureDescription;
@property (nullable, nonatomic, retain) NSString *videoLink;
@property (nullable, nonatomic, retain) Event *event;
@property (nullable, nonatomic, retain) NSSet<LectureMaterials *> *lectureMaterials;
@property (nullable, nonatomic, retain) NSSet<Speaker *> *speakers;

@end

@interface Lecture (CoreDataGeneratedAccessors)

- (void)addLectureMaterialsObject:(LectureMaterials *)value;
- (void)removeLectureMaterialsObject:(LectureMaterials *)value;
- (void)addLectureMaterials:(NSSet<LectureMaterials *> *)values;
- (void)removeLectureMaterials:(NSSet<LectureMaterials *> *)values;

- (void)addSpeakersObject:(Speaker *)value;
- (void)removeSpeakersObject:(Speaker *)value;
- (void)addSpeakers:(NSSet<Speaker *> *)values;
- (void)removeSpeakers:(NSSet<Speaker *> *)values;

@end

NS_ASSUME_NONNULL_END
