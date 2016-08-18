// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LastModifiedModelObject.m instead.

#import "_LastModifiedModelObject.h"

@implementation LastModifiedModelObjectID
@end

@implementation _LastModifiedModelObject

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
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

@implementation LastModifiedModelObjectAttributes 
+ (NSString *)lastModifiedDate {
	return @"lastModifiedDate";
}
+ (NSString *)lastModifiedId {
	return @"lastModifiedId";
}
+ (NSString *)name {
	return @"name";
}
@end

