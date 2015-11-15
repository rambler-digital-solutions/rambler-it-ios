//
//  Lecture+CoreDataProperties.h
//  Conferences
//
//  Created by Karpushin Artem on 15/11/15.
//  Copyright © 2015 Rambler. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Lecture.h"

NS_ASSUME_NONNULL_BEGIN

@interface Lecture (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *favourite;
@property (nullable, nonatomic, retain) NSNumber *name;
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
