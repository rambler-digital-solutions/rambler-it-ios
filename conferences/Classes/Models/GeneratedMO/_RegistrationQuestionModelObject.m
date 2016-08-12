// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RegistrationQuestionModelObject.m instead.

#import "_RegistrationQuestionModelObject.h"

const struct RegistrationQuestionModelObjectAttributes RegistrationQuestionModelObjectAttributes = {
	.name = @"name",
	.orderID = @"orderID",
};

const struct RegistrationQuestionModelObjectRelationships RegistrationQuestionModelObjectRelationships = {
	.event = @"event",
};

@implementation RegistrationQuestionModelObjectID
@end

@implementation _RegistrationQuestionModelObject

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"RegistrationQuestion" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"RegistrationQuestion";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"RegistrationQuestion" inManagedObjectContext:moc_];
}

- (RegistrationQuestionModelObjectID*)objectID {
	return (RegistrationQuestionModelObjectID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic name;

@dynamic orderID;

@dynamic event;

@end

