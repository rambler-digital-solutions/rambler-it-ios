// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TagModelObject.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@class Event;
@class Lecture;

@interface TagModelObjectID : NSManagedObjectID {}
@end

@interface _TagModelObject : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (nullable NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) TagModelObjectID *objectID;

@property (nonatomic, strong, nullable) NSString* name;

@property (nonatomic, strong, nullable) NSString* slug;

@property (nonatomic, strong, nullable) NSString* tagId;

@property (nonatomic, strong, nullable) Event *event;

@property (nonatomic, strong, nullable) NSSet<Lecture*> *lectures;
- (nullable NSMutableSet<Lecture*>*)lecturesSet;

@end

@interface _TagModelObject (LecturesCoreDataGeneratedAccessors)
- (void)addLectures:(NSSet<Lecture*>*)value_;
- (void)removeLectures:(NSSet<Lecture*>*)value_;
- (void)addLecturesObject:(Lecture*)value_;
- (void)removeLecturesObject:(Lecture*)value_;

@end

@interface _TagModelObject (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (NSString*)primitiveSlug;
- (void)setPrimitiveSlug:(NSString*)value;

- (NSString*)primitiveTagId;
- (void)setPrimitiveTagId:(NSString*)value;

- (Event*)primitiveEvent;
- (void)setPrimitiveEvent:(Event*)value;

- (NSMutableSet<Lecture*>*)primitiveLectures;
- (void)setPrimitiveLectures:(NSMutableSet<Lecture*>*)value;

@end

@interface TagModelObjectAttributes: NSObject 
+ (NSString *)name;
+ (NSString *)slug;
+ (NSString *)tagId;
@end

@interface TagModelObjectRelationships: NSObject
+ (NSString *)event;
+ (NSString *)lectures;
@end

NS_ASSUME_NONNULL_END
