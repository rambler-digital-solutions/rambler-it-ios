//
//  ReportsSearchViewOutput.h
//  Conferences
//
//  Created by k.zinovyev on 16.07.16.
//  Copyright © 2016 Rambler. All rights reserved.
//


#import <Foundation/Foundation.h>

@class EventPlainObject;
@class LecturePlainObject;
@class SpeakerPlainObject;

@protocol ReportsSearchViewOutput <NSObject>

- (void)setupView;

/**
 @author Zinovyev Konstantin
 
 Метод сообщает о том, что была нажата ячейка
 
 @param event Событие в нажатой ячейке
 */
- (void)didTriggerTapCellWithEvent:(EventPlainObject *)event;
- (void)didTriggerTapCellWithLecture:(LecturePlainObject *)lecture;
- (void)didTriggerTapCellWithSpeaker:(SpeakerPlainObject *)speaker;

/**
 @author Zinovyev Konstantin
 
 Обрабатывает текст в веденный в поиске
 
 @param text Введенный в поиск
 */
- (void)didSearchBarChangedWithText:(NSString *)text;

- (void)didTapClearPlaceholderView;
@end

