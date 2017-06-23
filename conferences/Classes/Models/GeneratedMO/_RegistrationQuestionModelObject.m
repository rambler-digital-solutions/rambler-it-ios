// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RegistrationQuestionModelObject.m instead.

#import "_RegistrationQuestionModelObject.h"

@implementation RegistrationQuestionModelObjectID
@end

@implementation _RegistrationQuestionModelObject

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
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

@implementation RegistrationQuestionModelObjectAttributes 
+ (NSString *)name {
	return @"name";
}
+ (NSString *)orderID {
	return @"orderID";
}
@end

@implementation RegistrationQuestionModelObjectRelationships 
+ (NSString *)event {
	return @"event";
}
@end

