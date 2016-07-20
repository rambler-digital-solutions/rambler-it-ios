// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LectureModelObject.m instead.

#import "_LectureModelObject.h"

@implementation LectureModelObjectID
@end

@implementation _LectureModelObject

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
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
	[self setFavourite:@(value_)];
}

- (BOOL)primitiveFavouriteValue {
	NSNumber *result = [self primitiveFavourite];
	return [result boolValue];
}

- (void)setPrimitiveFavouriteValue:(BOOL)value_ {
	[self setPrimitiveFavourite:@(value_)];
}

@dynamic lectureDescription;

@dynamic lectureId;

@dynamic name;

@dynamic event;

@dynamic lectureMaterials;

- (NSMutableSet<LectureMaterial*>*)lectureMaterialsSet {
	[self willAccessValueForKey:@"lectureMaterials"];

	NSMutableSet<LectureMaterial*> *result = (NSMutableSet<LectureMaterial*>*)[self mutableSetValueForKey:@"lectureMaterials"];

	[self didAccessValueForKey:@"lectureMaterials"];
	return result;
}

@dynamic speaker;

@dynamic tags;

- (NSMutableSet<Tag*>*)tagsSet {
	[self willAccessValueForKey:@"tags"];

	NSMutableSet<Tag*> *result = (NSMutableSet<Tag*>*)[self mutableSetValueForKey:@"tags"];

	[self didAccessValueForKey:@"tags"];
	return result;
}

@end

@implementation LectureModelObjectAttributes 
+ (NSString *)favourite {
	return @"favourite";
}
+ (NSString *)lectureDescription {
	return @"lectureDescription";
}
+ (NSString *)lectureId {
	return @"lectureId";
}
+ (NSString *)name {
	return @"name";
}
@end

@implementation LectureModelObjectRelationships 
+ (NSString *)event {
	return @"event";
}
+ (NSString *)lectureMaterials {
	return @"lectureMaterials";
}
+ (NSString *)speaker {
	return @"speaker";
}
+ (NSString *)tags {
	return @"tags";
}
@end

