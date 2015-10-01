//
//  Speaker+CoreDataProperties.h
//  Conferences
//
//  Created by Karpushin Artem on 01/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Speaker.h"

NS_ASSUME_NONNULL_BEGIN

@interface Speaker (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *pictureLink;
@property (nullable, nonatomic, retain) NSString *biography;
@property (nullable, nonatomic, retain) NSSet<SocialAccount *> *socialAccounts;
@property (nullable, nonatomic, retain) NSSet<Talk *> *talks;

@end

@interface Speaker (CoreDataGeneratedAccessors)

- (void)addSocialAccountsObject:(SocialAccount *)value;
- (void)removeSocialAccountsObject:(SocialAccount *)value;
- (void)addSocialAccounts:(NSSet<SocialAccount *> *)values;
- (void)removeSocialAccounts:(NSSet<SocialAccount *> *)values;

- (void)addTalksObject:(Talk *)value;
- (void)removeTalksObject:(Talk *)value;
- (void)addTalks:(NSSet<Talk *> *)values;
- (void)removeTalks:(NSSet<Talk *> *)values;

@end

NS_ASSUME_NONNULL_END
