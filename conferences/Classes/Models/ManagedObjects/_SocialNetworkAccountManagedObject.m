// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SocialNetworkAccountManagedObject.m instead.

#import "_SocialNetworkAccountManagedObject.h"

@implementation SocialNetworkAccountManagedObjectID
@end

@implementation _SocialNetworkAccountManagedObject

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
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

- (SocialNetworkAccountManagedObjectID*)objectID {
	return (SocialNetworkAccountManagedObjectID*)[super objectID];
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
	[self setType:@(value_)];
}

@dynamic speaker;

@end

@implementation SocialNetworkAccountManagedObjectAttributes 
+ (NSString *)profileLink {
	return @"profileLink";
}
+ (NSString *)type {
	return @"type";
}
@end

@implementation SocialNetworkAccountManagedObjectRelationships 
+ (NSString *)speaker {
	return @"speaker";
}
@end

