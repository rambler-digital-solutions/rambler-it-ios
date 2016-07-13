// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TechManagedObject.m instead.

#import "_TechManagedObject.h"

@implementation TechManagedObjectID
@end

@implementation _TechManagedObject

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Tech" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Tech";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Tech" inManagedObjectContext:moc_];
}

- (TechManagedObjectID*)objectID {
	return (TechManagedObjectID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic color;

@dynamic name;

@dynamic techId;

@dynamic events;

- (NSMutableSet<EventManagedObject*>*)eventsSet {
	[self willAccessValueForKey:@"events"];

	NSMutableSet<EventManagedObject*> *result = (NSMutableSet<EventManagedObject*>*)[self mutableSetValueForKey:@"events"];

	[self didAccessValueForKey:@"events"];
	return result;
}

@end

@implementation TechManagedObjectAttributes 
+ (NSString *)color {
	return @"color";
}
+ (NSString *)name {
	return @"name";
}
+ (NSString *)techId {
	return @"techId";
}
@end

@implementation TechManagedObjectRelationships 
+ (NSString *)events {
	return @"events";
}
@end

