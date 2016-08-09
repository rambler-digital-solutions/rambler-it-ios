//
//  IndexState+CoreDataProperties.m
//  Conferences
//
//  Created by Egor Tolstoy on 02/08/16.
//  Copyright © 2016 Rambler. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "IndexState+CoreDataProperties.h"

@implementation IndexState (CoreDataProperties)

@dynamic deleteIdentifiers;
@dynamic insertIdentifiers;
@dynamic updateIdentifiers;
@dynamic moveIdentifiers;
@dynamic lastChangeDate;
@dynamic numberOfIdentifiers;
@dynamic objectType;

@end
