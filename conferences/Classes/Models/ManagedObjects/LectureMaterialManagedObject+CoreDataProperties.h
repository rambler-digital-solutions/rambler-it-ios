//
//  LectureMaterialManagedObject+CoreDataProperties.h
//  Conferences
//
//  Created by Egor Tolstoy on 02/07/16.
//  Copyright © 2016 Rambler. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "LectureMaterialManagedObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface LectureMaterialManagedObject (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *lectureMaterialId;
@property (nullable, nonatomic, retain) NSString *link;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) LectureManagedObject *lecture;

@end

NS_ASSUME_NONNULL_END
