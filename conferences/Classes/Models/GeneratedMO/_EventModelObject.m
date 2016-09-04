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

- (NSMutableSet*)lecturesSet {
	[self willAccessValueForKey:@"lectures"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"lectures"];

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

