// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TagModelObject.m instead.

#import "_TagModelObject.h"

const struct TagModelObjectAttributes TagModelObjectAttributes = {
	.name = @"name",
	.slug = @"slug",
	.tagId = @"tagId",
};

const struct TagModelObjectRelationships TagModelObjectRelationships = {
	.lectures = @"lectures",
};

@implementation TagModelObjectID
@end

@implementation _TagModelObject

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Tag" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Tag";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Tag" inManagedObjectContext:moc_];
}

- (TagModelObjectID*)objectID {
	return (TagModelObjectID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic name;

@dynamic slug;

@dynamic tagId;

@dynamic lectures;

- (NSMutableSet*)lecturesSet {
	[self willAccessValueForKey:@"lectures"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"lectures"];

	[self didAccessValueForKey:@"lectures"];
	return result;
}

@end

