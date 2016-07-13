// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SpeakerManagedObject.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@class LectureManagedObject;
@class SocialNetworkAccountManagedObject;

@interface SpeakerManagedObjectID : NSManagedObjectID {}
@end

@interface _SpeakerManagedObject : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) SpeakerManagedObjectID *objectID;

@property (nonatomic, strong, nullable) NSString* biography;

@property (nonatomic, strong, nullable) NSString* company;

@property (nonatomic, strong, nullable) NSString* imageLink;

@property (nonatomic, strong, nullable) NSString* job;

@property (nonatomic, strong) NSString* name;

@property (nonatomic, strong) NSString* speakerId;

@property (nonatomic, strong, nullable) NSSet<LectureManagedObject*> *lectures;
- (nullable NSMutableSet<LectureManagedObject*>*)lecturesSet;

@property (nonatomic, strong, nullable) NSSet<SocialNetworkAccountManagedObject*> *socialNetworkAccounts;
- (nullable NSMutableSet<SocialNetworkAccountManagedObject*>*)socialNetworkAccountsSet;

@end

@interface _SpeakerManagedObject (LecturesCoreDataGeneratedAccessors)
- (void)addLectures:(NSSet<LectureManagedObject*>*)value_;
- (void)removeLectures:(NSSet<LectureManagedObject*>*)value_;
- (void)addLecturesObject:(LectureManagedObject*)value_;
- (void)removeLecturesObject:(LectureManagedObject*)value_;

@end

@interface _SpeakerManagedObject (SocialNetworkAccountsCoreDataGeneratedAccessors)
- (void)addSocialNetworkAccounts:(NSSet<SocialNetworkAccountManagedObject*>*)value_;
- (void)removeSocialNetworkAccounts:(NSSet<SocialNetworkAccountManagedObject*>*)value_;
- (void)addSocialNetworkAccountsObject:(SocialNetworkAccountManagedObject*)value_;
- (void)removeSocialNetworkAccountsObject:(SocialNetworkAccountManagedObject*)value_;

@end

@interface _SpeakerManagedObject (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveBiography;
- (void)setPrimitiveBiography:(NSString*)value;

- (NSString*)primitiveCompany;
- (void)setPrimitiveCompany:(NSString*)value;

- (NSString*)primitiveImageLink;
- (void)setPrimitiveImageLink:(NSString*)value;

- (NSString*)primitiveJob;
- (void)setPrimitiveJob:(NSString*)value;

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (NSString*)primitiveSpeakerId;
- (void)setPrimitiveSpeakerId:(NSString*)value;

- (NSMutableSet<LectureManagedObject*>*)primitiveLectures;
- (void)setPrimitiveLectures:(NSMutableSet<LectureManagedObject*>*)value;

- (NSMutableSet<SocialNetworkAccountManagedObject*>*)primitiveSocialNetworkAccounts;
- (void)setPrimitiveSocialNetworkAccounts:(NSMutableSet<SocialNetworkAccountManagedObject*>*)value;

@end

@interface SpeakerManagedObjectAttributes: NSObject 
+ (NSString *)biography;
+ (NSString *)company;
+ (NSString *)imageLink;
+ (NSString *)job;
+ (NSString *)name;
+ (NSString *)speakerId;
@end

@interface SpeakerManagedObjectRelationships: NSObject
+ (NSString *)lectures;
+ (NSString *)socialNetworkAccounts;
@end

NS_ASSUME_NONNULL_END
