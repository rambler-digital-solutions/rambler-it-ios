// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SpeakerModelObject.m instead.

#import "_SpeakerModelObject.h"

const struct SpeakerModelObjectAttributes SpeakerModelObjectAttributes = {
	.biography = @"biography",
	.company = @"company",
	.imageUrl = @"imageUrl",
	.job = @"job",
	.name = @"name",
	.speakerId = @"speakerId",
};

const struct SpeakerModelObjectRelationships SpeakerModelObjectRelationships = {
	.lectures = @"lectures",
	.socialNetworkAccounts = @"socialNetworkAccounts",
};

@implementation SpeakerModelObjectID
@end

@implementation _SpeakerModelObject

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
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

- (NSMutableSet*)lecturesSet {
	[self willAccessValueForKey:@"lectures"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"lectures"];

	[self didAccessValueForKey:@"lectures"];
	return result;
}

@dynamic socialNetworkAccounts;

- (NSMutableSet*)socialNetworkAccountsSet {
	[self willAccessValueForKey:@"socialNetworkAccounts"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"socialNetworkAccounts"];

	[self didAccessValueForKey:@"socialNetworkAccounts"];
	return result;
}

@end

