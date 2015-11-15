//
//  PastVideoTranslationTableViewCellObject.h
//  Conferences
//
//  Created by Karpushin Artem on 14/11/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <Nimbus/NimbusModels.h>

@class PlainEvent;

@interface PastVideoTranslationTableViewCellObject : NIFormElement <NICellObject>

+ (instancetype)objectWithElementID:(NSInteger)elementID event:(PlainEvent *)event;

@end
