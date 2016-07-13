//
//  ROSPonsomizerImplementation.h
//  Instamedia
//
//  Created by Aleksandr Sychev on 20.04.16.
//  Copyright © 2016 RAMBLER&Co. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ROSPonsomizer.h"

NS_ASSUME_NONNULL_BEGIN

/**
 @author Aleksandr Sychev

 Конвертер CoreData-объектов в Plain Old NSObjects.
 
 Предполагается, что в проекте используются следующие правила нейминга модельных объектов.
    - CoreData-объект называется согласно шаблону $Name$Entity (например, ROSArticleEntity).
    - Неизменяемый пользователем PONSO (machine-generated) называется согласно шаблону _$Name$PONSO (например, _ROSArticlePONSO),
      а изменяемый (human-generated) - $Name$PONSO (например, ROSArticlePONSO).
      Свойства в изменяемом и неизменямом PONSO должны совпадать.
 */
@interface ROSPonsomizerImplementation : NSObject <ROSPonsomizer>
@end

NS_ASSUME_NONNULL_END
