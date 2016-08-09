//
// TagEditMediator.h
// LiveJournal
// 
// Created by Golovko Mikhail on 21/12/15.
// Copyright © 2015 Rambler&Co. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TagModuleOutput.h"
#import "TagMediatorInput.h"
#import "TagEditMediatorInput.h"

@protocol TagChooseModuleInput;
@protocol TagEditMediatorOutput;
@protocol TagModuleInput;

/**
 @author Golovko Mikhail
 
 Медиатор для реализации взаимодействия модуля отображения тегов и модуля выбора тега.
 */
@interface TagEditMediator : NSObject <TagModuleOutput, TagMediatorInput, TagEditMediatorInput>

@property (nonatomic, weak) id<TagEditMediatorOutput> output;

@end