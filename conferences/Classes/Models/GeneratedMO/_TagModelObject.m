// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TagModelObject.m instead.

#import "_TagModelObject.h"

@implementation TagModelObjectID
@end

@implementation _TagModelObject

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

- (TagModelObjectID*)objectID {
	return (TagModelObjectID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic name;

@dynamic slug;

@dynamic tagId;

@dynamic event;

@dynamic lectures;

- (NSMutableSet<LectureModelObject*>*)lecturesSet {
	[self willAccessValueForKey:@"lectures"];

	NSMutableSet<LectureModelObject*> *result = (NSMutableSet<LectureModelObject*>*)[self mutableSetValueForKey:@"lectures"];

	[self didAccessValueForKey:@"lectures"];
	return result;
}

@end

@implementation TagModelObjectAttributes 
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

@implementation TagModelObjectRelationships 
+ (NSString *)event {
	return @"event";
}
+ (NSString *)lectures {
	return @"lectures";
}
@end

