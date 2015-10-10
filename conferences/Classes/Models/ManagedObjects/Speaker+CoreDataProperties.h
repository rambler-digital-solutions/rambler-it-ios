//
//  Speaker+CoreDataProperties.h
//  Conferences
//
//  Created by Karpushin Artem on 10/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Speaker.h"

NS_ASSUME_NONNULL_BEGIN

@interface Speaker (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *biography;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *pictureLink;
@property (nullable, nonatomic, retain) NSSet<Lecture *> *lectures;
@property (nullable, nonatomic, retain) NSSet<SocialNetworkAccount *> *socialNetworkAccounts;

@end

@interface Speaker (CoreDataGeneratedAccessors)

- (void)addLecturesObject:(Lecture *)value;
- (void)removeLecturesObject:(Lecture *)value;
- (void)addLectures:(NSSet<Lecture *> *)values;
- (void)removeLectures:(NSSet<Lecture *> *)values;

- (void)addSocialNetworkAccountsObject:(SocialNetworkAccount *)value;
- (void)removeSocialNetworkAccountsObject:(SocialNetworkAccount *)value;
- (void)addSocialNetworkAccounts:(NSSet<SocialNetworkAccount *> *)values;
- (void)removeSocialNetworkAccounts:(NSSet<SocialNetworkAccount *> *)values;

@end

NS_ASSUME_NONNULL_END
