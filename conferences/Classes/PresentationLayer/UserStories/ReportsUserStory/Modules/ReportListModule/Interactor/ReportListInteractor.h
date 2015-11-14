//
//  ReportListInteractor.h
//  Conferences
//
//  Created by Karpushin Artem on 08/11/15.
//  Copyright 2015 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReportListInteractorInput.h"

@protocol ReportListInteractorOutput;
@protocol EventService;
@protocol PrototypeMapper;

@interface ReportListInteractor : NSObject<ReportListInteractorInput>

@property (nonatomic, weak) id<ReportListInteractorOutput> output;
@property (strong, nonatomic) id <EventService> eventService;
@property (strong, nonatomic) id <PrototypeMapper> eventPrototypeMapper;

@end

