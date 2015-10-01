//
//  Event+CoreDataProperties.m
//  Conferences
//
//  Created by Karpushin Artem on 01/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Event+CoreDataProperties.h"

@implementation Event (CoreDataProperties)

@dynamic name;
@dynamic eventDescription;
@dynamic timePadID;
@dynamic liveStreamLink;
@dynamic twitterLink;
@dynamic startDate;
@dynamic endDate;
@dynamic talks;
@dynamic registrationQuestions;

@end
