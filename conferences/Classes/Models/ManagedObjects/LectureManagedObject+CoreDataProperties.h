//
//  LectureManagedObject+CoreDataProperties.h
//  Conferences
//
//  Created by Egor Tolstoy on 02/07/16.
//  Copyright © 2016 Rambler. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "LectureManagedObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface LectureManagedObject (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *favourite;
@property (nullable, nonatomic, retain) NSString *lectureDescription;
@property (nullable, nonatomic, retain) NSString *lectureId;
@property (nullable, nonatomic, retain) NSString *name;
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
