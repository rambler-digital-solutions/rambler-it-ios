//
//  NSManagedObjectID+LJStringConversion.h
//  LiveJournal
//
//  Created by Egor Tolstoy on 13/01/16.
//  Copyright © 2016 Rambler&Co. All rights reserved.
//

#import <CoreData/CoreData.h>

/**
 @author Egor Tolstoy
 
 Категория над NSManagedObjectID,
 */
@interface NSManagedObjectID (LJStringConversion)

/**
 @author Egor Tolstoy
 
 Метод конвертирует строковое представление MOID в сам MOID
 
 @param string  Строковое представление
 @param context Контекст
 
 @return NSManagedObjectID
 */
+ (NSManagedObjectID *)managedObjectIDFromString:(NSString *)string
                                       inContext:(NSManagedObjectContext *)context;

/**
 @author Egor Tolstoy
 
 Метод конвертирует MOID в строку
 
 @return Строковое представление
 */
- (NSString *)stringRepresentation;

@end
