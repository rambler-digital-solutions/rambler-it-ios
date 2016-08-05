//
//  NITyphoonInjectableCell.h
//  LiveJournal
//
//  Created by Egor Tolstoy on 03/02/16.
//  Copyright © 2016 Rambler&Co. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 @author Egor Tolstoy
 
 Протокол, который должен быть реализован ячейкой, поддерживающей инъекцию при помощи Typhoon
 */
@protocol NITyphoonInjectableCell <NSObject>

/**
 @author Egor Tolstoy
 
 Флаг хранит состояние - была ли ячейка уже сконфигурирована Typhoon'ом.
 Флаг нужен, чтобы при реюзе ячейки, которая должна хранить свое состояние, мы бы не инжектили новые зависимости.
 */
@property (assign, nonatomic) BOOL isConfigured;

@end
