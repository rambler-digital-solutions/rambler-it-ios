//
//  ReportListPresenter.h
//  Conferences
//
//  Created by Karpushin Artem on 08/11/15.
//  Copyright 2015 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReportListViewOutput.h"
#import "ReportListInteractorOutput.h"

@protocol ReportListViewInput;
@protocol ReportListInteractorInput;
@protocol ReportListRouterInput;

@interface ReportListPresenter : NSObject<ReportListViewOutput,ReportListInteractorOutput>

@property (nonatomic, weak) id<ReportListViewInput> view;
@property (nonatomic, strong) id<ReportListInteractorInput>  interactor;
@property (nonatomic, strong) id<ReportListRouterInput> router;

@end

