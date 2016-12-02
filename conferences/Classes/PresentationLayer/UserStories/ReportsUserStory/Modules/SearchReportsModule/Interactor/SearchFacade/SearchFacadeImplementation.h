//
//  SearchFacadeImplementation.h
//  Conferences
//
//  Created by s.sarkisyan on 02.12.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SearchFacade.h"

@protocol EventService;
@protocol LectureService;
@protocol SpeakerService;
@protocol ROSPonsomizer;

@interface SearchFacadeImplementation : NSObject <SearchFacade>

@property (nonatomic, strong) id <EventService> eventService;
@property (nonatomic, strong) id <SpeakerService> speakerService;
@property (nonatomic, strong) id <LectureService> lectureService;
@property (nonatomic, strong) id <ROSPonsomizer> ponsomizer;

@end
