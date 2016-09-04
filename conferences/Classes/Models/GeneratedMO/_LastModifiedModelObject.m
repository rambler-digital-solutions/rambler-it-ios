// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LastModifiedModelObject.m instead.

#import "_LastModifiedModelObject.h"

const struct LastModifiedModelObjectAttributes LastModifiedModelObjectAttributes = {
	.lastModifiedDate = @"lastModifiedDate",
	.lastModifiedId = @"lastModifiedId",
	.name = @"name",
};

@implementation LastModifiedModelObjectID
@end

@implementation _LastModifiedModelObject

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"LastModified" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"LastModified";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"LastModified" inManagedObjectContext:moc_];
}

- (LastModifiedModelObjectID*)objectID {
	return (LastModifiedModelObjectID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic lastModifiedDate;

@dynamic lastModifiedId;

@dynamic name;

@end

