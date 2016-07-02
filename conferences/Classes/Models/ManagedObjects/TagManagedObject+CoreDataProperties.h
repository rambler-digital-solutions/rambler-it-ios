//
//  TagManagedObject+CoreDataProperties.h
//  Conferences
//
//  Created by Egor Tolstoy on 02/07/16.
//  Copyright © 2016 Rambler. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "TagManagedObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface TagManagedObject (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *slug;
@property (nullable, nonatomic, retain) NSString *tagId;
@property (nullable, nonatomic, retain) NSSet<LectureManagedObject *> *lectures;

@end

@interface TagManagedObject (CoreDataGeneratedAccessors)

- (void)addLecturesObject:(LectureManagedObject *)value;
- (void)removeLecturesObject:(LectureManagedObject *)value;
- (void)addLectures:(NSSet<LectureManagedObject *> *)values;
- (void)removeLectures:(NSSet<LectureManagedObject *> *)values;

@end

NS_ASSUME_NONNULL_END
