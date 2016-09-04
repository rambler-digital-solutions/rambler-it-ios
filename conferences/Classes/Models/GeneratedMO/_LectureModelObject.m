// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LectureModelObject.m instead.

#import "_LectureModelObject.h"

const struct LectureModelObjectAttributes LectureModelObjectAttributes = {
	.favourite = @"favourite",
	.lectureDescription = @"lectureDescription",
	.lectureId = @"lectureId",
	.name = @"name",
};

const struct LectureModelObjectRelationships LectureModelObjectRelationships = {
	.event = @"event",
	.lectureMaterials = @"lectureMaterials",
	.speaker = @"speaker",
	.tags = @"tags",
};

@implementation LectureModelObjectID
@end

@implementation _LectureModelObject

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Lecture" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Lecture";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Lecture" inManagedObjectContext:moc_];
}

- (LectureModelObjectID*)objectID {
	return (LectureModelObjectID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"favouriteValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"favourite"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic favourite;

- (BOOL)favouriteValue {
	NSNumber *result = [self favourite];
	return [result boolValue];
}

- (void)setFavouriteValue:(BOOL)value_ {
	[self setFavourite:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveFavouriteValue {
	NSNumber *result = [self primitiveFavourite];
	return [result boolValue];
}

- (void)setPrimitiveFavouriteValue:(BOOL)value_ {
	[self setPrimitiveFavourite:[NSNumber numberWithBool:value_]];
}

@dynamic lectureDescription;

@dynamic lectureId;

@dynamic name;

@dynamic event;

@dynamic lectureMaterials;

- (NSMutableSet*)lectureMaterialsSet {
	[self willAccessValueForKey:@"lectureMaterials"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"lectureMaterials"];

	[self didAccessValueForKey:@"lectureMaterials"];
	return result;
}

@dynamic speaker;

@dynamic tags;

- (NSMutableSet*)tagsSet {
	[self willAccessValueForKey:@"tags"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"tags"];

	[self didAccessValueForKey:@"tags"];
	return result;
}

@end

