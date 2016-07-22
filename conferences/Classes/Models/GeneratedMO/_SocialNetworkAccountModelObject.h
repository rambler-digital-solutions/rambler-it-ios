// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SocialNetworkAccountModelObject.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@class SpeakerModelObject;

@interface SocialNetworkAccountModelObjectID : NSManagedObjectID {}
@end

@interface _SocialNetworkAccountModelObject : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) SocialNetworkAccountModelObjectID *objectID;

@property (nonatomic, strong) NSString* profileLink;

@property (nonatomic, strong, nullable) NSNumber* type;

@property (atomic) int16_t typeValue;
- (int16_t)typeValue;
- (void)setTypeValue:(int16_t)value_;

@property (nonatomic, strong, nullable) SpeakerModelObject *speaker;

@end

@interface _SocialNetworkAccountModelObject (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveProfileLink;
- (void)setPrimitiveProfileLink:(NSString*)value;

- (SpeakerModelObject*)primitiveSpeaker;
- (void)setPrimitiveSpeaker:(SpeakerModelObject*)value;

@end

@interface SocialNetworkAccountModelObjectAttributes: NSObject 
+ (NSString *)profileLink;
+ (NSString *)type;
@end

@interface SocialNetworkAccountModelObjectRelationships: NSObject
+ (NSString *)speaker;
@end

NS_ASSUME_NONNULL_END
