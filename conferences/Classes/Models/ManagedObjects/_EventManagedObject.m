// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to EventManagedObject.m instead.

#import "_EventManagedObject.h"

@implementation EventManagedObjectID
@end

@implementation _EventManagedObject

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
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

- (EventManagedObjectID*)objectID {
	return (EventManagedObjectID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic endDate;

@dynamic eventId;

@dynamic liveStreamLink;

@dynamic name;

@dynamic startDate;

@dynamic timePadID;

@dynamic twitterTag;

@dynamic lectures;

- (NSMutableSet<LectureManagedObject*>*)lecturesSet {
	[self willAccessValueForKey:@"lectures"];

	NSMutableSet<LectureManagedObject*> *result = (NSMutableSet<LectureManagedObject*>*)[self mutableSetValueForKey:@"lectures"];

	[self didAccessValueForKey:@"lectures"];
	return result;
}

@dynamic metaEvent;

@dynamic registrationQuestions;

- (NSMutableSet<RegistrationQuestionManagedObject*>*)registrationQuestionsSet {
	[self willAccessValueForKey:@"registrationQuestions"];

	NSMutableSet<RegistrationQuestionManagedObject*> *result = (NSMutableSet<RegistrationQuestionManagedObject*>*)[self mutableSetValueForKey:@"registrationQuestions"];

	[self didAccessValueForKey:@"registrationQuestions"];
	return result;
}

@dynamic tech;

@end

@implementation EventManagedObjectAttributes 
+ (NSString *)endDate {
	return @"endDate";
}
+ (NSString *)eventId {
	return @"eventId";
}
+ (NSString *)liveStreamLink {
	return @"liveStreamLink";
}
+ (NSString *)name {
	return @"name";
}
+ (NSString *)startDate {
	return @"startDate";
}
+ (NSString *)timePadID {
	return @"timePadID";
}
+ (NSString *)twitterTag {
	return @"twitterTag";
}
@end

@implementation EventManagedObjectRelationships 
+ (NSString *)lectures {
	return @"lectures";
}
+ (NSString *)metaEvent {
	return @"metaEvent";
}
+ (NSString *)registrationQuestions {
	return @"registrationQuestions";
}
+ (NSString *)tech {
	return @"tech";
}
@end

