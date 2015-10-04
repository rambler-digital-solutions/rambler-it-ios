//
//  LectureMaterials+CoreDataProperties.h
//  Conferences
//
//  Created by Karpushin Artem on 03/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "LectureMaterials.h"

NS_ASSUME_NONNULL_BEGIN

@interface LectureMaterials (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *link;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) Lecture *lecture;

@end

NS_ASSUME_NONNULL_END
