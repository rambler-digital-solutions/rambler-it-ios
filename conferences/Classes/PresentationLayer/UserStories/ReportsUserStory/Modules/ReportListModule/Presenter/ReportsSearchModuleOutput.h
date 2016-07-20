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
 
 Метод сообщает презентеру, о том что был загружен модуль ReportsSearchModule
 
 @param reportsSearchModule Ссылка на модуль
 */
- (void)didLoadReportsSearchModule:(id<ReportsSearchModuleInput>)reportsSearchModule;

/**
 @author Zinovyev Konstantin
 
 Метод сообщает презентеру, о том что было совершенно нажатие на прозрачный экран в модуле поиска
 */
- (void)didTapClearScreenSearchModule;

@end

