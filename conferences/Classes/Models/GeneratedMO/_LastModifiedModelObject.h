// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LastModifiedModelObject.h instead.

#import <CoreData/CoreData.h>

extern const struct LastModifiedModelObjectAttributes {
	__unsafe_unretained NSString *lastModifiedDate;
	__unsafe_unretained NSString *lastModifiedId;
	__unsafe_unretained NSString *name;
} LastModifiedModelObjectAttributes;

@interface LastModifiedModelObjectID : NSManagedObjectID {}
@end

@interface _LastModifiedModelObject : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) LastModifiedModelObjectID* objectID;

@property (nonatomic, strong) NSDate* lastModifiedDate;

//- (BOOL)validateLastModifiedDate:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* lastModifiedId;

//- (BOOL)validateLastModifiedId:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@end

@interface _LastModifiedModelObject (CoreDataGeneratedPrimitiveAccessors)

- (NSDate*)primitiveLastModifiedDate;
- (void)setPrimitiveLastModifiedDate:(NSDate*)value;

- (NSString*)primitiveLastModifiedId;
- (void)setPrimitiveLastModifiedId:(NSString*)value;

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

@end
