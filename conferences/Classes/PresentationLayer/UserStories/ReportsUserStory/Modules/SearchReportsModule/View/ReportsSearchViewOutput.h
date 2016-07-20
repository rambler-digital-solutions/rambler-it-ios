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

/**
 @author Zinovyev Konstantin
 
 Метод сообщает презентеру о том что, требуется провести первоначальную настройку view
 */
- (void)setupView;

/**
 @author Zinovyev Konstantin
 
 Метод сообщает презентеру о том, что была нажата ячейка с событием
 
 @param event Объект событие в нажатой ячейке
 */
- (void)didTriggerTapCellWithEvent:(EventPlainObject *)event;

/**
 @author Zinovyev Konstantin
 
 Метод сообщает презентеру о том, что была нажата ячейка с докладом
 
 @param event Объект доклад в нажатой ячейке
 */
- (void)didTriggerTapCellWithLecture:(LecturePlainObject *)lecture;

/**
 @author Zinovyev Konstantin
 
 Метод сообщает презентеру о том, что была нажата ячейка с докладчиком
 
 @param event Объект докладчика в нажатой ячейке
 */
- (void)didTriggerTapCellWithSpeaker:(SpeakerPlainObject *)speaker;

/**
 @author Zinovyev Konstantin
 
 Обрабатывает текст в веденный в поиске
 
 @param text Введенный в поиск
 */
- (void)didSearchBarChangedWithText:(NSString *)text;

/**
 @author Zinovyev Konstantin
 
 Сообщает презентеру о нажатии на прозрачный экран
 */
- (void)didTapClearPlaceholderView;
@end

