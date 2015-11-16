//
//  EventTableViewCellActionProtocol.h
//  Conferences
//
//  Created by Karpushin Artem on 08/11/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "EventInfoTableViewCellActionProtocol.h"
#import "LectureInfoTableViewCellActionProtocol.h"
#import "SignUpAndSaveToCalendarEventTableViewCellActionProtocol.h"
#import "CurrentVideoTranslationTableViewCellActionProtocol.h"
#import "EventDescriptionTableViewCellActionProtocol.h"

@protocol EventTableViewCellActionProtocol <EventInfoTableViewCellActionProtocol, LectureInfoTableViewCellActionProtocol, SignUpAndSaveToCalendarEventTableViewCellActionProtocol, CurrentVideoTranslationTableViewCellActionProtocol, EventDescriptionTableViewCellActionProtocol>

@end
