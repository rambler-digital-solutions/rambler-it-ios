//
//  ReportsSearchInteractor.h
//  Conferences
//
//  Created by k.zinovyev on 16.07.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReportsSearchInteractorInput.h"

@protocol ReportSearchInteractorOutput;
@protocol EventService;
@protocol LectureService;
@protocol SpeakerService;
@protocol PrototypeMapper;
@class EventTypeDeterminator;

@interface ReportsSearchInteractor : NSObject

@property (weak, nonatomic) id <ReportsSearchInteractorInput> output;
@property (strong, nonatomic) id <EventService> eventService;
@property (strong, nonatomic) id <SpeakerService> speakerService;
@property (strong, nonatomic) id <LectureService> lectureService;
@property (strong, nonatomic) id <PrototypeMapper> eventPrototypeMapper;
@property (strong, nonatomic) id <PrototypeMapper> lecturePrototypeMapper;
@property (strong, nonatomic) id <PrototypeMapper> speakerPrototypeMapper;
@property (strong, nonatomic) EventTypeDeterminator *eventTypeDeterminator;

@end