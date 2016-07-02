//
//  SocialNetworkAccountManagedObject+CoreDataProperties.h
//  Conferences
//
//  Created by Egor Tolstoy on 02/07/16.
//  Copyright © 2016 Rambler. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "SocialNetworkAccountManagedObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface SocialNetworkAccountManagedObject (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *profileLink;
@property (nullable, nonatomic, retain) NSNumber *type;
@property (nullable, nonatomic, retain) SpeakerManagedObject *speaker;

@end

NS_ASSUME_NONNULL_END
