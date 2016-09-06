// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to EventModelObject.m instead.

#import "_EventModelObject.h"

const struct EventModelObjectAttributes EventModelObjectAttributes = {
	.endDate = @"endDate",
	.eventDescription = @"eventDescription",
	.eventId = @"eventId",
	.eventSubtitle = @"eventSubtitle",
	.eventType = @"eventType",
	.imageUrl = @"imageUrl",
	.lastVisitDate = @"lastVisitDate",
	.liveStreamLink = @"liveStreamLink",
	.name = @"name",
	.startDate = @"startDate",
	.timePadID = @"timePadID",
	.twitterTag = @"twitterTag",
};

const struct EventModelObjectRelationships EventModelObjectRelationships = {
	.lectures = @"lectures",
	.metaEvent = @"metaEvent",
	.registrationQuestions = @"registrationQuestions",
	.tech = @"tech",
};

@implementation EventModelObjectID
@end

@implementation _EventModelObject

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Event" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Event";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Event" inManagedObjectContext:moc_];
}

- (EventModelObjectID*)objectID {
	return (EventModelObjectID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"eventTypeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"eventType"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic endDate;

@dynamic eventDescription;

@dynamic eventId;

@dynamic eventSubtitle;

@dynamic eventType;

- (int32_t)eventTypeValue {
	NSNumber *result = [self eventType];
	return [result intValue];
}

- (void)setEventTypeValue:(int32_t)value_ {
	[self setEventType:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveEventTypeValue {
	NSNumber *result = [self primitiveEventType];
	return [result intValue];
}

- (void)setPrimitiveEventTypeValue:(int32_t)value_ {
	[self setPrimitiveEventType:[NSNumber numberWithInt:value_]];
}

@dynamic imageUrl;

@dynamic lastVisitDate;

@dynamic liveStreamLink;

@dynamic name;

@dynamic startDate;

@dynamic timePadID;

@dynamic twitterTag;

@dynamic lectures;

- (NSMutableOrderedSet*)lecturesSet {
	[self willAccessValueForKey:@"lectures"];

	NSMutableOrderedSet *result = (NSMutableOrderedSet*)[self mutableOrderedSetValueForKey:@"lectures"];

	[self didAccessValueForKey:@"lectures"];
	return result;
}

@dynamic metaEvent;

@dynamic registrationQuestions;

- (NSMutableSet*)registrationQuestionsSet {
	[self willAccessValueForKey:@"registrationQuestions"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"registrationQuestions"];

	[self didAccessValueForKey:@"registrationQuestions"];
	return result;
}

@dynamic tech;

@end

@implementation _EventModelObject (LecturesCoreDataGeneratedAccessors)
- (void)addLectures:(NSOrderedSet*)value_ {
	[self.lecturesSet unionOrderedSet:value_];
}
- (void)removeLectures:(NSOrderedSet*)value_ {
	[self.lecturesSet minusOrderedSet:value_];
}
- (void)addLecturesObject:(LectureModelObject*)value_ {
	[self.lecturesSet addObject:value_];
}
- (void)removeLecturesObject:(LectureModelObject*)value_ {
	[self.lecturesSet removeObject:value_];
}
- (void)insertObject:(LectureModelObject*)value inLecturesAtIndex:(NSUInteger)idx {
    NSIndexSet* indexes = [NSIndexSet indexSetWithIndex:idx];
    [self willChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"lectures"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self lectures]];
    [tmpOrderedSet insertObject:value atIndex:idx];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"lectures"];
    [self didChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"lectures"];
}
- (void)removeObjectFromLecturesAtIndex:(NSUInteger)idx {
    NSIndexSet* indexes = [NSIndexSet indexSetWithIndex:idx];
    [self willChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"lectures"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self lectures]];
    [tmpOrderedSet removeObjectAtIndex:idx];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"lectures"];
    [self didChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"lectures"];
}
- (void)insertLectures:(NSArray *)value atIndexes:(NSIndexSet *)indexes {
    [self willChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"lectures"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self lectures]];
    [tmpOrderedSet insertObjects:value atIndexes:indexes];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"lectures"];
    [self didChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"lectures"];
}
- (void)removeLecturesAtIndexes:(NSIndexSet *)indexes {
    [self willChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"lectures"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self lectures]];
    [tmpOrderedSet removeObjectsAtIndexes:indexes];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"lectures"];
    [self didChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"lectures"];
}
- (void)replaceObjectInLecturesAtIndex:(NSUInteger)idx withObject:(LectureModelObject*)value {
    NSIndexSet* indexes = [NSIndexSet indexSetWithIndex:idx];
    [self willChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"lectures"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self lectures]];
    [tmpOrderedSet replaceObjectAtIndex:idx withObject:value];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"lectures"];
    [self didChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"lectures"];
}
- (void)replaceLecturesAtIndexes:(NSIndexSet *)indexes withLectures:(NSArray *)value {
    [self willChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"lectures"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self lectures]];
    [tmpOrderedSet replaceObjectsAtIndexes:indexes withObjects:value];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"lectures"];
    [self didChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"lectures"];
}
@end

