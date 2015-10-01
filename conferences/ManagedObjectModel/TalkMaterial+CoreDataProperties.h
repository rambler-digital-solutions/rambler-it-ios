//
//  TalkMaterial+CoreDataProperties.h
//  Conferences
//
//  Created by Karpushin Artem on 01/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "TalkMaterial.h"

NS_ASSUME_NONNULL_BEGIN

@interface TalkMaterial (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *link;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) Talk *talkMaterial;

@end

NS_ASSUME_NONNULL_END
