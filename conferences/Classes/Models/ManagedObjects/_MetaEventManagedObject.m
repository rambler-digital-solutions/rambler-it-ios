// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to MetaEventManagedObject.m instead.

#import "_MetaEventManagedObject.h"

@implementation MetaEventManagedObjectID
@end

@implementation _MetaEventManagedObject

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"MetaEvent" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"MetaEvent";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"MetaEvent" inManagedObjectContext:moc_];
}

- (MetaEventManagedObjectID*)objectID {
	return (MetaEventManagedObjectID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic imageUrlPath;

@dynamic metaEventDescription;

@dynamic metaEventId;

@dynamic name;

@dynamic websiteUrlPath;

@dynamic events;

- (NSMutableSet<EventManagedObject*>*)eventsSet {
	[self willAccessValueForKey:@"events"];

	NSMutableSet<EventManagedObject*> *result = (NSMutableSet<EventManagedObject*>*)[self mutableSetValueForKey:@"events"];

	[self didAccessValueForKey:@"events"];
	return result;
}

@end

@implementation MetaEventManagedObjectAttributes 
+ (NSString *)imageUrlPath {
	return @"imageUrlPath";
}
+ (NSString *)metaEventDescription {
	return @"metaEventDescription";
}
+ (NSString *)metaEventId {
	return @"metaEventId";
}
+ (NSString *)name {
	return @"name";
}
+ (NSString *)websiteUrlPath {
	return @"websiteUrlPath";
}
@end

@implementation MetaEventManagedObjectRelationships 
+ (NSString *)events {
	return @"events";
}
@end

