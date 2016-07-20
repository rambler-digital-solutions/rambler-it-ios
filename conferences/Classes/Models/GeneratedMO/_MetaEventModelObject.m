// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to MetaEventModelObject.m instead.

#import "_MetaEventModelObject.h"

@implementation MetaEventModelObjectID
@end

@implementation _MetaEventModelObject

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"MetaEvent" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"MetaEvent";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"MetaEvent" inManagedObjectContext:moc_];
}

- (MetaEventModelObjectID*)objectID {
	return (MetaEventModelObjectID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic imageUrlPath;

@dynamic metaEventDescription;

@dynamic metaEventId;

@dynamic name;

@dynamic websiteUrlPath;

@dynamic events;

- (NSMutableSet<Event*>*)eventsSet {
	[self willAccessValueForKey:@"events"];

	NSMutableSet<Event*> *result = (NSMutableSet<Event*>*)[self mutableSetValueForKey:@"events"];

	[self didAccessValueForKey:@"events"];
	return result;
}

@end

@implementation MetaEventModelObjectAttributes 
+ (NSString *)imageUrlPath {
	return @"imageUrlPath";
}
+ (NSString *)metaEventDescription {
	return @"metaEventDescription";
}
+ (NSString *)metaEventId {
	return @"metaEventId";
}
+ (NSString *)name {
	return @"name";
}
+ (NSString *)websiteUrlPath {
	return @"websiteUrlPath";
}
@end

@implementation MetaEventModelObjectRelationships 
+ (NSString *)events {
	return @"events";
}
@end

