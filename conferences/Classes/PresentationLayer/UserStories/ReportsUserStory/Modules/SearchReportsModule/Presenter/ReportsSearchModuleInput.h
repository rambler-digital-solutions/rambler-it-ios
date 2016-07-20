//
//  ReportsSearchModuleInput.h
//  Conferences
//
//  Created by k.zinovyev on 18.07.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ViperMcFlurry/ViperMcFlurry.h>
#import "ReportsSearchModuleOutput.h"

@protocol ReportsSearchModuleInput <RamblerViperModuleInput>


/**
 @author Zinovyev Konstantin
 
 Метод настраивающий модуль при изменении текста в поле поиска
 
 @param searchText текст в поле поиска
 */
- (void)updateModuleWithText:(NSString *)searchText;

/**
 @author Zinovyev Konstantin
 
 Метод настраивающий модуль при изменении текста в поле поиска
 */
- (void)closeSearchModule;


@end

