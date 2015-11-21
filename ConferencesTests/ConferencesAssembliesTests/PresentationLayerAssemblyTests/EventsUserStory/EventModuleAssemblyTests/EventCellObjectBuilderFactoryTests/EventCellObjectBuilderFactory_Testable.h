//
//  EventCellObjectBuilderFactory_Testable.h
//  Conferences
//
//  Created by Karpushin Artem on 21/11/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "EventCellObjectBuilderFactory.h"

@protocol CellObjectBuilderProtocol;

@interface EventCellObjectBuilderFactory ()

- (id <CellObjectBuilderProtocol>)currentEventCellObjectBuilder;
- (id <CellObjectBuilderProtocol>)futureEventCellObjectBuilder;
- (id <CellObjectBuilderProtocol>)pastEventCellObjectBuilder;

@end
