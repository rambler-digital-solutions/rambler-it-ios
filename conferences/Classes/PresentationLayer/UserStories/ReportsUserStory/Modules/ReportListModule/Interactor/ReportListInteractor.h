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

/**
 *  Interactor модуля, который 1
 *	
 */
@interface ReportListInteractor : NSObject<ReportListInteractorInput>

@property (nonatomic, weak) id<ReportListInteractorOutput> output;

@end

