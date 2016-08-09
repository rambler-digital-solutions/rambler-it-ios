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

- (NSMutableSet<LectureMaterialModelObject*>*)lectureMaterialsSet {
	[self willAccessValueForKey:@"lectureMaterials"];

	NSMutableSet<LectureMaterialModelObject*> *result = (NSMutableSet<LectureMaterialModelObject*>*)[self mutableSetValueForKey:@"lectureMaterials"];

	[self didAccessValueForKey:@"lectureMaterials"];
	return result;
}

@dynamic speaker;

@dynamic tags;

- (NSMutableOrderedSet<TagModelObject*>*)tagsSet {
	[self willAccessValueForKey:@"tags"];

	NSMutableOrderedSet<TagModelObject*> *result = (NSMutableOrderedSet<TagModelObject*>*)[self mutableOrderedSetValueForKey:@"tags"];

	[self didAccessValueForKey:@"tags"];
	return result;
}

@end

@implementation _LectureModelObject (TagsCoreDataGeneratedAccessors)
- (void)addTags:(NSOrderedSet<TagModelObject*>*)value_ {
	[self.tagsSet unionOrderedSet:value_];
}
- (void)removeTags:(NSOrderedSet<TagModelObject*>*)value_ {
	[self.tagsSet minusOrderedSet:value_];
}
- (void)addTagsObject:(TagModelObject*)value_ {
	[self.tagsSet addObject:value_];
}
- (void)removeTagsObject:(TagModelObject*)value_ {
	[self.tagsSet removeObject:value_];
}
- (void)insertObject:(TagModelObject*)value inTagsAtIndex:(NSUInteger)idx {
    NSIndexSet* indexes = [NSIndexSet indexSetWithIndex:idx];
    [self willChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"tags"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self tags]];
    [tmpOrderedSet insertObject:value atIndex:idx];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"tags"];
    [self didChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"tags"];
}
- (void)removeObjectFromTagsAtIndex:(NSUInteger)idx {
    NSIndexSet* indexes = [NSIndexSet indexSetWithIndex:idx];
    [self willChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"tags"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self tags]];
    [tmpOrderedSet removeObjectAtIndex:idx];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"tags"];
    [self didChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"tags"];
}
- (void)insertTags:(NSArray *)value atIndexes:(NSIndexSet *)indexes {
    [self willChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"tags"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self tags]];
    [tmpOrderedSet insertObjects:value atIndexes:indexes];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"tags"];
    [self didChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"tags"];
}
- (void)removeTagsAtIndexes:(NSIndexSet *)indexes {
    [self willChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"tags"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self tags]];
    [tmpOrderedSet removeObjectsAtIndexes:indexes];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"tags"];
    [self didChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"tags"];
}
- (void)replaceObjectInTagsAtIndex:(NSUInteger)idx withObject:(TagModelObject*)value {
    NSIndexSet* indexes = [NSIndexSet indexSetWithIndex:idx];
    [self willChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"tags"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self tags]];
    [tmpOrderedSet replaceObjectAtIndex:idx withObject:value];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"tags"];
    [self didChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"tags"];
}
- (void)replaceTagsAtIndexes:(NSIndexSet *)indexes withTags:(NSArray *)value {
    [self willChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"tags"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self tags]];
    [tmpOrderedSet replaceObjectsAtIndexes:indexes withObjects:value];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"tags"];
    [self didChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"tags"];
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

