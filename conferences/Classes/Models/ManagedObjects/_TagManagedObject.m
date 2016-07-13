// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TagManagedObject.m instead.

#import "_TagManagedObject.h"

@implementation TagManagedObjectID
@end

@implementation _TagManagedObject

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Tag" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Tag";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Tag" inManagedObjectContext:moc_];
}

- (TagManagedObjectID*)objectID {
	return (TagManagedObjectID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic name;

@dynamic slug;

@dynamic tagId;

@dynamic lectures;

- (NSMutableSet<LectureManagedObject*>*)lecturesSet {
	[self willAccessValueForKey:@"lectures"];

	NSMutableSet<LectureManagedObject*> *result = (NSMutableSet<LectureManagedObject*>*)[self mutableSetValueForKey:@"lectures"];

	[self didAccessValueForKey:@"lectures"];
	return result;
}

@end

@implementation TagManagedObjectAttributes 
+ (NSString *)name {
	return @"name";
}
+ (NSString *)slug {
	return @"slug";
}
+ (NSString *)tagId {
	return @"tagId";
}
@end

@implementation TagManagedObjectRelationships 
+ (NSString *)lectures {
	return @"lectures";
}
@end

