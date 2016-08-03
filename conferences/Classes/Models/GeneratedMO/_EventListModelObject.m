// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to EventListModelObject.m instead.

#import "_EventListModelObject.h"

@implementation EventListModelObjectID
@end

@implementation _EventListModelObject

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"EventList" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"EventList";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"EventList" inManagedObjectContext:moc_];
}

- (EventListModelObjectID*)objectID {
	return (EventListModelObjectID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic eventListId;

@dynamic lastModified;

@dynamic name;

@end

@implementation EventListModelObjectAttributes 
+ (NSString *)eventListId {
	return @"eventListId";
}
+ (NSString *)lastModified {
	return @"lastModified";
}
+ (NSString *)name {
	return @"name";
}
@end

