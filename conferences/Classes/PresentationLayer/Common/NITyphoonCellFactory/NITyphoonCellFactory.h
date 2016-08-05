//
//  NITyphoonCellFactory.h
//  LiveJournal
//
//  Created by Egor Tolstoy on 11/12/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import <Nimbus/NimbusModels.h>
#import "TableViewCellAssembly.h"

/**
 @author Egor Tolstoy
 
 Фабрика ячеек Nimbus, использующая Typhoon для инъекции зависимостей
 */
@interface NITyphoonCellFactory : NICellFactory

/**
 @author Egor Tolstoy
 
 Метод инжектит зависимости в ячейку, если для нее настроена конфигурация зависимостей
 
 @param cell Исходная ячефка
 */
+ (void)configureInjectableCellIfNeeded:(UITableViewCell *)cell;

@end
