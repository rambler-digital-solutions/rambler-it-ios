//
//  IndexState+CoreDataProperties.h
//  Conferences
//
//  Created by Egor Tolstoy on 02/08/16.
//  Copyright © 2016 Rambler. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "IndexState.h"

NS_ASSUME_NONNULL_BEGIN

@interface IndexState (CoreDataProperties)

@property (nullable, nonatomic, retain) id deleteIdentifiers;
@property (nullable, nonatomic, retain) id insertIdentifiers;
@property (nullable, nonatomic, retain) id updateIdentifiers;
@property (nullable, nonatomic, retain) id moveIdentifiers;
@property (nullable, nonatomic, retain) NSDate *lastChangeDate;
@property (nullable, nonatomic, retain) NSNumber *numberOfIdentifiers;
@property (nullable, nonatomic, retain) NSString *objectType;

@end

NS_ASSUME_NONNULL_END
