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

@class Lecture;
@class SocialNetworkAccount;

@interface SpeakerModelObjectID : NSManagedObjectID {}
@end

@interface _SpeakerModelObject : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (nullable NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) SpeakerModelObjectID *objectID;

@property (nonatomic, strong, nullable) NSString* biography;

@property (nonatomic, strong, nullable) NSString* company;

@property (nonatomic, strong, nullable) NSString* imageUrl;

@property (nonatomic, strong, nullable) NSString* job;

@property (nonatomic, strong) NSString* name;

@property (nonatomic, strong) NSString* speakerId;

@property (nonatomic, strong, nullable) NSSet<Lecture*> *lectures;
- (nullable NSMutableSet<Lecture*>*)lecturesSet;

@property (nonatomic, strong, nullable) NSSet<SocialNetworkAccount*> *socialNetworkAccounts;
- (nullable NSMutableSet<SocialNetworkAccount*>*)socialNetworkAccountsSet;

@end

@interface _SpeakerModelObject (LecturesCoreDataGeneratedAccessors)
- (void)addLectures:(NSSet<Lecture*>*)value_;
- (void)removeLectures:(NSSet<Lecture*>*)value_;
- (void)addLecturesObject:(Lecture*)value_;
- (void)removeLecturesObject:(Lecture*)value_;

@end

@interface _SpeakerModelObject (SocialNetworkAccountsCoreDataGeneratedAccessors)
- (void)addSocialNetworkAccounts:(NSSet<SocialNetworkAccount*>*)value_;
- (void)removeSocialNetworkAccounts:(NSSet<SocialNetworkAccount*>*)value_;
- (void)addSocialNetworkAccountsObject:(SocialNetworkAccount*)value_;
- (void)removeSocialNetworkAccountsObject:(SocialNetworkAccount*)value_;

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

- (NSMutableSet<Lecture*>*)primitiveLectures;
- (void)setPrimitiveLectures:(NSMutableSet<Lecture*>*)value;

- (NSMutableSet<SocialNetworkAccount*>*)primitiveSocialNetworkAccounts;
- (void)setPrimitiveSocialNetworkAccounts:(NSMutableSet<SocialNetworkAccount*>*)value;

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
