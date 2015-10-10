//
//  Lecture.h
//  Conferences
//
//  Created by Karpushin Artem on 10/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Event, LectureMaterials, Speaker;

NS_ASSUME_NONNULL_BEGIN

@interface Lecture : NSManagedObject

// Insert code here to declare functionality of your managed object subclass

@end

NS_ASSUME_NONNULL_END

#import "Lecture+CoreDataProperties.h"
