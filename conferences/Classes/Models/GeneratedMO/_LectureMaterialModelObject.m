// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LectureMaterialModelObject.m instead.

#import "_LectureMaterialModelObject.h"

const struct LectureMaterialModelObjectAttributes LectureMaterialModelObjectAttributes = {
	.lectureMaterialId = @"lectureMaterialId",
	.link = @"link",
	.name = @"name",
	.type = @"type",
};

const struct LectureMaterialModelObjectRelationships LectureMaterialModelObjectRelationships = {
	.lecture = @"lecture",
};

@implementation LectureMaterialModelObjectID
@end

@implementation _LectureMaterialModelObject

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
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

- (LectureMaterialModelObjectID*)objectID {
	return (LectureMaterialModelObjectID*)[super objectID];
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

@dynamic lectureMaterialId;

@dynamic link;

@dynamic name;

@dynamic type;

- (int16_t)typeValue {
	NSNumber *result = [self type];
	return [result shortValue];
}

- (void)setTypeValue:(int16_t)value_ {
	[self setType:[NSNumber numberWithShort:value_]];
}

@dynamic lecture;

@end

