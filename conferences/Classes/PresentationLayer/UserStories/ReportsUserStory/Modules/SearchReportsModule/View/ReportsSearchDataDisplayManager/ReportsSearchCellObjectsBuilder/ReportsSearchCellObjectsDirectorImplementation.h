//
//  ReportsSearchCellObjectsDirector.h
//  Conferences
//
//  Created by k.zinovyev on 25.07.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ReportsSearchCellObjectsBuilderImplementation;
@protocol ReportsSearchCellObjectsDirector;
@protocol ReportsSearchCellObjectsBuilder;

@interface ReportsSearchCellObjectsDirectorImplementation <ReportsSearchCellObjectsDirector> : NSObject

@property (nonatomic, strong, readonly) id<ReportsSearchCellObjectsBuilder> builder;

- (instancetype)initWithBuilder:(id<ReportsSearchCellObjectsBuilder>)builder;


@end
