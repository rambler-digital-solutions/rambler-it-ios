// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SpeakerModelObject.h instead.

#import <CoreData/CoreData.h>

extern const struct SpeakerModelObjectAttributes {
	__unsafe_unretained NSString *biography;
	__unsafe_unretained NSString *company;
	__unsafe_unretained NSString *imageUrl;
	__unsafe_unretained NSString *job;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *speakerId;
} SpeakerModelObjectAttributes;

extern const struct SpeakerModelObjectRelationships {
	__unsafe_unretained NSString *lectures;
	__unsafe_unretained NSString *socialNetworkAccounts;
} SpeakerModelObjectRelationships;

@class LectureModelObject;
@class SocialNetworkAccountModelObject;

@interface SpeakerModelObjectID : NSManagedObjectID {}
@end

@interface _SpeakerModelObject : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) SpeakerModelObjectID* objectID;

@property (nonatomic, strong) NSString* biography;

//- (BOOL)validateBiography:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* company;

//- (BOOL)validateCompany:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* imageUrl;

//- (BOOL)validateImageUrl:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* job;

//- (BOOL)validateJob:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* speakerId;

//- (BOOL)validateSpeakerId:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *lectures;

- (NSMutableSet*)lecturesSet;

@property (nonatomic, strong) NSSet *socialNetworkAccounts;

- (NSMutableSet*)socialNetworkAccountsSet;

@end

@interface _SpeakerModelObject (LecturesCoreDataGeneratedAccessors)
- (void)addLectures:(NSSet*)value_;
- (void)removeLectures:(NSSet*)value_;
- (void)addLecturesObject:(LectureModelObject*)value_;
- (void)removeLecturesObject:(LectureModelObject*)value_;

@end

@interface _SpeakerModelObject (SocialNetworkAccountsCoreDataGeneratedAccessors)
- (void)addSocialNetworkAccounts:(NSSet*)value_;
- (void)removeSocialNetworkAccounts:(NSSet*)value_;
- (void)addSocialNetworkAccountsObject:(SocialNetworkAccountModelObject*)value_;
- (void)removeSocialNetworkAccountsObject:(SocialNetworkAccountModelObject*)value_;

@end

@interface _SpeakerModelObject (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveBiography;
- (void)setPrimitiveBiography:(NSString*)value;

- (NSString*)primitiveCompany;
- (void)setPrimitiveCompany:(NSString*)value;

- (NSString*)primitiveImageUrl;
- (void)setPrimitiveImageUrl:(NSString*)value;

- (NSString*)primitiveJob;
- (void)setPrimitiveJob:(NSString*)value;

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (NSString*)primitiveSpeakerId;
- (void)setPrimitiveSpeakerId:(NSString*)value;

- (NSMutableSet*)primitiveLectures;
- (void)setPrimitiveLectures:(NSMutableSet*)value;

- (NSMutableSet*)primitiveSocialNetworkAccounts;
- (void)setPrimitiveSocialNetworkAccounts:(NSMutableSet*)value;

@end
