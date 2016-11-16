// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SpeakerModelObject.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@class LectureModelObject;
@class SocialNetworkAccountModelObject;

@interface SpeakerModelObjectID : NSManagedObjectID {}
@end

@interface _SpeakerModelObject : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) SpeakerModelObjectID *objectID;

@property (nonatomic, strong, nullable) NSString* biography;

@property (nonatomic, strong, nullable) NSString* company;

@property (nonatomic, strong, nullable) NSString* imageUrl;

@property (nonatomic, strong, nullable) NSString* job;

@property (nonatomic, strong) NSString* name;

@property (nonatomic, strong) NSString* speakerId;

@property (nonatomic, strong, nullable) NSSet<LectureModelObject*> *lectures;
- (nullable NSMutableSet<LectureModelObject*>*)lecturesSet;

@property (nonatomic, strong, nullable) NSSet<SocialNetworkAccountModelObject*> *socialNetworkAccounts;
- (nullable NSMutableSet<SocialNetworkAccountModelObject*>*)socialNetworkAccountsSet;

@end

@interface _SpeakerModelObject (LecturesCoreDataGeneratedAccessors)
- (void)addLectures:(NSSet<LectureModelObject*>*)value_;
- (void)removeLectures:(NSSet<LectureModelObject*>*)value_;
- (void)addLecturesObject:(LectureModelObject*)value_;
- (void)removeLecturesObject:(LectureModelObject*)value_;

@end

@interface _SpeakerModelObject (SocialNetworkAccountsCoreDataGeneratedAccessors)
- (void)addSocialNetworkAccounts:(NSSet<SocialNetworkAccountModelObject*>*)value_;
- (void)removeSocialNetworkAccounts:(NSSet<SocialNetworkAccountModelObject*>*)value_;
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

- (NSMutableSet<LectureModelObject*>*)primitiveLectures;
- (void)setPrimitiveLectures:(NSMutableSet<LectureModelObject*>*)value;

- (NSMutableSet<SocialNetworkAccountModelObject*>*)primitiveSocialNetworkAccounts;
- (void)setPrimitiveSocialNetworkAccounts:(NSMutableSet<SocialNetworkAccountModelObject*>*)value;

@end

@interface SpeakerModelObjectAttributes: NSObject 
+ (NSString *)biography;
+ (NSString *)company;
+ (NSString *)imageUrl;
+ (NSString *)job;
+ (NSString *)name;
+ (NSString *)speakerId;
@end

@interface SpeakerModelObjectRelationships: NSObject
+ (NSString *)lectures;
+ (NSString *)socialNetworkAccounts;
@end

NS_ASSUME_NONNULL_END
