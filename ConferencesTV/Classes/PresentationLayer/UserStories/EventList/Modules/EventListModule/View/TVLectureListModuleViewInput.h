//
//  TVLectureListModuleTVLectureListModuleViewInput.h
//  Conferences
//
//  Created by Porokhov Artem on 21/12/2016.
//  Copyright © 2016 Rambler&Co. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LecturePlainObject;

@protocol TVLectureListModuleViewInput <NSObject>

/**
 @author Porokhov Artem

 Метод настраивает начальный стейт view
 */
- (void)setupInitialState;

/**
 @author Porokhov Artem
 
 Метод обновляет коллекцию лекций
 */
- (void)updateLectureListWithLectures:(NSArray <LecturePlainObject *> *)lectures;

@end
