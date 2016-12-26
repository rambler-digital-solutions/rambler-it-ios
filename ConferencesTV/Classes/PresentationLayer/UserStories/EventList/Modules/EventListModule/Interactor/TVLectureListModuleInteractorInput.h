//
//  TVLectureListModuleTVLectureListModuleInteractorInput.h
//  Conferences
//
//  Created by Porokhov Artem on 21/12/2016.
//  Copyright © 2016 Rambler&Co. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TagPlainObject;

@protocol TVLectureListModuleInteractorInput <NSObject>

/**
 @author Porokhov Artem
 
 Метод обновляет список лекций с фильтром по заданным тегам
 */
- (void)updateLectureListWithTags:(NSSet <TagPlainObject *> *)tags;

@end
