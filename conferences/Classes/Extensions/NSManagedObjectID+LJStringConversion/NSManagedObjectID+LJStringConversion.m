//
//  NSManagedObjectID+LJStringConversion.m
//  LiveJournal
//
//  Created by Egor Tolstoy on 13/01/16.
//  Copyright © 2016 Rambler&Co. All rights reserved.
//

#import "NSManagedObjectID+LJStringConversion.h"

@implementation NSManagedObjectID (LJStringConversion)

+ (NSManagedObjectID *)managedObjectIDFromString:(NSString *)string
                                       inContext:(NSManagedObjectContext *)context {
    NSURL *managedObjectIDURL = [NSURL URLWithString:string];
    NSPersistentStoreCoordinator *coordinator = context.persistentStoreCoordinator;
    NSManagedObjectID *managedObjectID = [coordinator managedObjectIDForURIRepresentation:managedObjectIDURL];
    return managedObjectID;
}

- (NSString *)stringRepresentation {
    return [[self URIRepresentation] absoluteString];
}

@end
