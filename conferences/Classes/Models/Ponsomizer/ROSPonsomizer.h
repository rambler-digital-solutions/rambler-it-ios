//
//  ROSPonsomizer.h
//  Instamedia
//
//  Created by Aleksandr Sychev on 20.04.16.
//  Copyright © 2016 RAMBLER&Co. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 @author Aleksandr Sychev

 Протокол конвертера CoreData-объектов в Plain Old NSObjects.
 */
@protocol ROSPonsomizer <NSObject>

@required

/**
 @author Aleksandr Sychev

 Преобразует CoreData-объекты в плоские.

 @param object NSManagedObject (или наследник) или NSArray, NSSet, NSOrderedSet, состоящих из них.

 @return PONSO или NSArray, NSSet, NSOrderedSet, состоящий из PONSO.
 */
- (id)convertObject:(id)object;

@end

NS_ASSUME_NONNULL_END
