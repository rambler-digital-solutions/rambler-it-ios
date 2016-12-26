//
//  TVLectureListModuleTVLectureListModuleInteractorOutput.h
//  Conferences
//
//  Created by Porokhov Artem on 21/12/2016.
//  Copyright © 2016 Rambler&Co. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LecturePlainObject;

@protocol TVLectureListModuleInteractorOutput <NSObject>

/**
 @author Porokhov Artem
 
 Метод отправляет полученный список лекций презентеру
 */
- (void)didUpdateLectureListWithLectures:(NSArray <LecturePlainObject *> *)lectures;

@end
