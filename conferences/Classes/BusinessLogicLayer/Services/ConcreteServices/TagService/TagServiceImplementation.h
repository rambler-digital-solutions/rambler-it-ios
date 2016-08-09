//
// TagServiceImplementation.h
// LiveJournal
// 
// Created by Golovko Mikhail on 15/12/15.
// Copyright © 2015 Rambler&Co. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TagService.h"

@class TagServicePredicateBuilder;

/**
 @author Golovko Mikhail
 
 Реализация сервиса для работы с тегами.
 */
@interface TagServiceImplementation : NSObject <TagService>

@property (nonatomic, strong) TagServicePredicateBuilder *predicateBuilder;

@end