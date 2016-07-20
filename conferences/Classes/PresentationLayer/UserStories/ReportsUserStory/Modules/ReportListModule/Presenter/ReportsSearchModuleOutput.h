//
//  ReportSearchModuleOutput.h
//  Conferences
//
//  Created by k.zinovyev on 18.07.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ViperMcFlurry/ViperMcFlurry.h>

@protocol ReportsSearchModuleInput;

@protocol ReportsSearchModuleOutput <RamblerViperModuleOutput>

/**
 @author Zinovyev Konstantin
 
 Метод первоначально настраивающий модуль при нажатии на поле поиска
 
 @param searchText текст в поле поиска
 */
- (void)didLoadReportsSearchModule:(id<ReportsSearchModuleInput>)reportsSearchModule;

- (void)didTapClearScreenSearchModule;

@end

