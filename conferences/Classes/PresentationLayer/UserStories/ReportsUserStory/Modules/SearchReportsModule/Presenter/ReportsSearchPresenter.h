//
//  SearchReportsPresenter.h
//  Conferences
//
//  Created by k.zinovyev on 16.07.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReportsSearchViewInput.h"
#import "ReportsSearchInteractorInput.h"
#import "ReportsSearchModuleInput.h"
#import "ReportsSearchRouterInput.h"

@interface ReportsSearchPresenter <ReportsSearchModuleInput> : NSObject

@property (nonatomic, weak) id<ReportsSearchViewInput> view;
@property (nonatomic, strong) id<ReportsSearchInteractorInput>  interactor;
@property (nonatomic, strong) id<ReportsSearchRouterInput> router;
@property (nonatomic, weak) id<ReportsSearchModuleOutput> moduleOutput;

@end
