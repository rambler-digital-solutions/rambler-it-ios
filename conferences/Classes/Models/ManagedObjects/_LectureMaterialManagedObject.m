// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LectureMaterialManagedObject.m instead.

#import "_LectureMaterialManagedObject.h"

@implementation LectureMaterialManagedObjectID
@end

@implementation _LectureMaterialManagedObject

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"LectureMaterial" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"LectureMaterial";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"LectureMaterial" inManagedObjectContext:moc_];
}

- (LectureMaterialManagedObjectID*)objectID {
	return (LectureMaterialManagedObjectID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic lectureMaterialId;

@dynamic link;

@dynamic name;

@dynamic lecture;

@end

@implementation LectureMaterialManagedObjectAttributes 
+ (NSString *)lectureMaterialId {
	return @"lectureMaterialId";
}
+ (NSString *)link {
	return @"link";
}
+ (NSString *)name {
	return @"name";
}
@end

@implementation LectureMaterialManagedObjectRelationships 
+ (NSString *)lecture {
	return @"lecture";
}
@end

