// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SpeakerModelObject.m instead.

#import "_SpeakerModelObject.h"

@implementation SpeakerModelObjectID
@end

@implementation _SpeakerModelObject

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

- (SpeakerModelObjectID*)objectID {
	return (SpeakerModelObjectID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic biography;

@dynamic company;

@dynamic imageUrl;

@dynamic job;

@dynamic name;

@dynamic speakerId;

@dynamic lectures;

- (NSMutableSet<Lecture*>*)lecturesSet {
	[self willAccessValueForKey:@"lectures"];

	NSMutableSet<Lecture*> *result = (NSMutableSet<Lecture*>*)[self mutableSetValueForKey:@"lectures"];

	[self didAccessValueForKey:@"lectures"];
	return result;
}

@dynamic socialNetworkAccounts;

- (NSMutableSet<SocialNetworkAccount*>*)socialNetworkAccountsSet {
	[self willAccessValueForKey:@"socialNetworkAccounts"];

	NSMutableSet<SocialNetworkAccount*> *result = (NSMutableSet<SocialNetworkAccount*>*)[self mutableSetValueForKey:@"socialNetworkAccounts"];

	[self didAccessValueForKey:@"socialNetworkAccounts"];
	return result;
}

@end

@implementation SpeakerModelObjectAttributes 
+ (NSString *)biography {
	return @"biography";
}
+ (NSString *)company {
	return @"company";
}
+ (NSString *)imageUrl {
	return @"imageUrl";
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

@implementation SpeakerModelObjectRelationships 
+ (NSString *)lectures {
	return @"lectures";
}
+ (NSString *)socialNetworkAccounts {
	return @"socialNetworkAccounts";
}
@end

