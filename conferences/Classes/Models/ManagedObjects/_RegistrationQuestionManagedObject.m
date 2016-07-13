// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RegistrationQuestionManagedObject.m instead.

#import "_RegistrationQuestionManagedObject.h"

@implementation RegistrationQuestionManagedObjectID
@end

@implementation _RegistrationQuestionManagedObject

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

- (RegistrationQuestionManagedObjectID*)objectID {
	return (RegistrationQuestionManagedObjectID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic name;

@dynamic orderID;

@dynamic event;

@end

@implementation RegistrationQuestionManagedObjectAttributes 
+ (NSString *)name {
	return @"name";
}
+ (NSString *)orderID {
	return @"orderID";
}
@end

@implementation RegistrationQuestionManagedObjectRelationships 
+ (NSString *)event {
	return @"event";
}
@end

