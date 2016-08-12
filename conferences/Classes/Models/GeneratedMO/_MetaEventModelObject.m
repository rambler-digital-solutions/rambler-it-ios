// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to MetaEventModelObject.m instead.

#import "_MetaEventModelObject.h"

const struct MetaEventModelObjectAttributes MetaEventModelObjectAttributes = {
	.imageUrlPath = @"imageUrlPath",
	.metaEventDescription = @"metaEventDescription",
	.metaEventId = @"metaEventId",
	.name = @"name",
	.websiteUrlPath = @"websiteUrlPath",
};

const struct MetaEventModelObjectRelationships MetaEventModelObjectRelationships = {
	.events = @"events",
};

@implementation MetaEventModelObjectID
@end

@implementation _MetaEventModelObject

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
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

- (MetaEventModelObjectID*)objectID {
	return (MetaEventModelObjectID*)[super objectID];
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

- (NSMutableSet*)eventsSet {
	[self willAccessValueForKey:@"events"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"events"];

	[self didAccessValueForKey:@"events"];
	return result;
}

@end

