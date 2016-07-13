// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SocialNetworkAccountManagedObject.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@class SpeakerManagedObject;

@interface SocialNetworkAccountManagedObjectID : NSManagedObjectID {}
@end

@interface _SocialNetworkAccountManagedObject : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) SocialNetworkAccountManagedObjectID *objectID;

@property (nonatomic, strong) NSString* profileLink;

@property (nonatomic, strong, nullable) NSNumber* type;

@property (atomic) int16_t typeValue;
- (int16_t)typeValue;
- (void)setTypeValue:(int16_t)value_;

@property (nonatomic, strong, nullable) SpeakerManagedObject *speaker;

@end

@interface _SocialNetworkAccountManagedObject (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveProfileLink;
- (void)setPrimitiveProfileLink:(NSString*)value;

- (SpeakerManagedObject*)primitiveSpeaker;
- (void)setPrimitiveSpeaker:(SpeakerManagedObject*)value;

@end

@interface SocialNetworkAccountManagedObjectAttributes: NSObject 
+ (NSString *)profileLink;
+ (NSString *)type;
@end

@interface SocialNetworkAccountManagedObjectRelationships: NSObject
+ (NSString *)speaker;
@end

NS_ASSUME_NONNULL_END
