// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TechModelObject.m instead.

#import "_TechModelObject.h"

const struct TechModelObjectAttributes TechModelObjectAttributes = {
	.color = @"color",
	.name = @"name",
	.techId = @"techId",
};

const struct TechModelObjectRelationships TechModelObjectRelationships = {
	.events = @"events",
};

@implementation TechModelObjectID
@end

@implementation _TechModelObject

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
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

- (NSMutableSet*)eventsSet {
	[self willAccessValueForKey:@"events"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"events"];

	[self didAccessValueForKey:@"events"];
	return result;
}

@end

