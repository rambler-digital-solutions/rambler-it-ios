//
//  SpeakerManagedObject+CoreDataProperties.h
//  Conferences
//
//  Created by Egor Tolstoy on 02/07/16.
//  Copyright © 2016 Rambler. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "SpeakerManagedObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface SpeakerManagedObject (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *biography;
@property (nullable, nonatomic, retain) NSString *company;
@property (nullable, nonatomic, retain) NSString *imageLink;
@property (nullable, nonatomic, retain) NSString *job;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *speakerId;
@property (nullable, nonatomic, retain) NSSet<LectureManagedObject *> *lectures;
@property (nullable, nonatomic, retain) NSSet<SocialNetworkAccountManagedObject *> *socialNetworkAccounts;

@end

@interface SpeakerManagedObject (CoreDataGeneratedAccessors)

- (void)addLecturesObject:(LectureManagedObject *)value;
- (void)removeLecturesObject:(LectureManagedObject *)value;
- (void)addLectures:(NSSet<LectureManagedObject *> *)values;
- (void)removeLectures:(NSSet<LectureManagedObject *> *)values;

- (void)addSocialNetworkAccountsObject:(SocialNetworkAccountManagedObject *)value;
- (void)removeSocialNetworkAccountsObject:(SocialNetworkAccountManagedObject *)value;
- (void)addSocialNetworkAccounts:(NSSet<SocialNetworkAccountManagedObject *> *)values;
- (void)removeSocialNetworkAccounts:(NSSet<SocialNetworkAccountManagedObject *> *)values;

@end

NS_ASSUME_NONNULL_END
