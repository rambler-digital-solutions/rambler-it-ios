// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SocialNetworkAccountModelObject.m instead.

#import "_SocialNetworkAccountModelObject.h"

const struct SocialNetworkAccountModelObjectAttributes SocialNetworkAccountModelObjectAttributes = {
	.profileLink = @"profileLink",
	.type = @"type",
};

const struct SocialNetworkAccountModelObjectRelationships SocialNetworkAccountModelObjectRelationships = {
	.speaker = @"speaker",
};

@implementation SocialNetworkAccountModelObjectID
@end

@implementation _SocialNetworkAccountModelObject

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"SocialNetworkAccount" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"SocialNetworkAccount";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"SocialNetworkAccount" inManagedObjectContext:moc_];
}

- (SocialNetworkAccountModelObjectID*)objectID {
	return (SocialNetworkAccountModelObjectID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"typeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"type"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic profileLink;

@dynamic type;

- (int16_t)typeValue {
	NSNumber *result = [self type];
	return [result shortValue];
}

- (void)setTypeValue:(int16_t)value_ {
	[self setType:[NSNumber numberWithShort:value_]];
}

@dynamic speaker;

@end

