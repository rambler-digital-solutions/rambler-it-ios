// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SpeakerManagedObject.m instead.

#import "_SpeakerManagedObject.h"

@implementation SpeakerManagedObjectID
@end

@implementation _SpeakerManagedObject

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Speaker" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Speaker";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Speaker" inManagedObjectContext:moc_];
}

- (SpeakerManagedObjectID*)objectID {
	return (SpeakerManagedObjectID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic biography;

@dynamic company;

@dynamic imageLink;

@dynamic job;

@dynamic name;

@dynamic speakerId;

@dynamic lectures;

- (NSMutableSet<LectureManagedObject*>*)lecturesSet {
	[self willAccessValueForKey:@"lectures"];

	NSMutableSet<LectureManagedObject*> *result = (NSMutableSet<LectureManagedObject*>*)[self mutableSetValueForKey:@"lectures"];

	[self didAccessValueForKey:@"lectures"];
	return result;
}

@dynamic socialNetworkAccounts;

- (NSMutableSet<SocialNetworkAccountManagedObject*>*)socialNetworkAccountsSet {
	[self willAccessValueForKey:@"socialNetworkAccounts"];

	NSMutableSet<SocialNetworkAccountManagedObject*> *result = (NSMutableSet<SocialNetworkAccountManagedObject*>*)[self mutableSetValueForKey:@"socialNetworkAccounts"];

	[self didAccessValueForKey:@"socialNetworkAccounts"];
	return result;
}

@end

@implementation SpeakerManagedObjectAttributes 
+ (NSString *)biography {
	return @"biography";
}
+ (NSString *)company {
	return @"company";
}
+ (NSString *)imageLink {
	return @"imageLink";
}
+ (NSString *)job {
	return @"job";
}
+ (NSString *)name {
	return @"name";
}
+ (NSString *)speakerId {
	return @"speakerId";
}
@end

@implementation SpeakerManagedObjectRelationships 
+ (NSString *)lectures {
	return @"lectures";
}
+ (NSString *)socialNetworkAccounts {
	return @"socialNetworkAccounts";
}
@end

