//
//  RegistrationQuestion+CoreDataProperties.h
//  Conferences
//
//  Created by Karpushin Artem on 10/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "RegistrationQuestion.h"

NS_ASSUME_NONNULL_BEGIN

@interface RegistrationQuestion (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *orderID;
@property (nullable, nonatomic, retain) Event *event;

@end

NS_ASSUME_NONNULL_END
