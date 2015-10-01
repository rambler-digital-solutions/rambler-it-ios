//
//  Event.h
//  Conferences
//
//  Created by Karpushin Artem on 01/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Lecture, RegistrationQuestion;

NS_ASSUME_NONNULL_BEGIN

@interface Event : NSManagedObject

// Insert code here to declare functionality of your managed object subclass

@end

NS_ASSUME_NONNULL_END

#import "Event+CoreDataProperties.h"
