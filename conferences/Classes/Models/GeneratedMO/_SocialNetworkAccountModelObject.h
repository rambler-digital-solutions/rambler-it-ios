// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SocialNetworkAccountModelObject.h instead.

#import <CoreData/CoreData.h>

extern const struct SocialNetworkAccountModelObjectAttributes {
	__unsafe_unretained NSString *profileLink;
	__unsafe_unretained NSString *type;
} SocialNetworkAccountModelObjectAttributes;

extern const struct SocialNetworkAccountModelObjectRelationships {
	__unsafe_unretained NSString *speaker;
} SocialNetworkAccountModelObjectRelationships;

@class SpeakerModelObject;

@interface SocialNetworkAccountModelObjectID : NSManagedObjectID {}
@end

@interface _SocialNetworkAccountModelObject : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) SocialNetworkAccountModelObjectID* objectID;

@property (nonatomic, strong) NSString* profileLink;

//- (BOOL)validateProfileLink:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* type;

@property (atomic) int16_t typeValue;
- (int16_t)typeValue;
- (void)setTypeValue:(int16_t)value_;

//- (BOOL)validateType:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) SpeakerModelObject *speaker;

//- (BOOL)validateSpeaker:(id*)value_ error:(NSError**)error_;

@end

@interface _SocialNetworkAccountModelObject (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveProfileLink;
- (void)setPrimitiveProfileLink:(NSString*)value;

- (SpeakerModelObject*)primitiveSpeaker;
- (void)setPrimitiveSpeaker:(SpeakerModelObject*)value;

@end
