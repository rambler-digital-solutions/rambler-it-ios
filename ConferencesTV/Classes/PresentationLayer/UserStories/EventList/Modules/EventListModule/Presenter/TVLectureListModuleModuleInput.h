//
//  TVLectureListModuleTVLectureListModuleModuleInput.h
//  Conferences
//
//  Created by Porokhov Artem on 21/12/2016.
//  Copyright © 2016 Rambler&Co. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ViperMcFlurry/ViperMcFlurry.h>

@protocol TVLectureListModuleModuleInput <RamblerViperModuleInput>

/**
 @author Porokhov Artem

 Метод инициирует стартовую конфигурацию текущего модуля
 */
- (void)configureModule;

@end
