//
//  SocialAccount+CoreDataProperties.h
//  Conferences
//
//  Created by Karpushin Artem on 01/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "SocialAccount.h"

NS_ASSUME_NONNULL_BEGIN

@interface SocialAccount (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *profileLink;
@property (nullable, nonatomic, retain) Speaker *speaker;

@end

NS_ASSUME_NONNULL_END
