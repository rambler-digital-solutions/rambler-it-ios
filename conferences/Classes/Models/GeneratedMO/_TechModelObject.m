// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TechModelObject.m instead.

#import "_TechModelObject.h"

@implementation TechModelObjectID
@end

@implementation _TechModelObject

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

- (TechModelObjectID*)objectID {
	return (TechModelObjectID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic color;

@dynamic name;

@dynamic techId;

@dynamic events;

- (NSMutableSet<EventModelObject*>*)eventsSet {
	[self willAccessValueForKey:@"events"];

	NSMutableSet<EventModelObject*> *result = (NSMutableSet<EventModelObject*>*)[self mutableSetValueForKey:@"events"];

	[self didAccessValueForKey:@"events"];
	return result;
}

@end

@implementation TechModelObjectAttributes 
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

@implementation TechModelObjectRelationships 
+ (NSString *)events {
	return @"events";
}
@end

