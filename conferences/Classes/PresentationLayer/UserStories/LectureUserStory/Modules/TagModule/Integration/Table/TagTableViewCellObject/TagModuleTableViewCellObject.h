//
// TagModuleTableViewCellObject.h
// LiveJournal
// 
// Created by Golovko Mikhail on 15/12/15.
// Copyright © 2015 Rambler&Co. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Nimbus/NIFormCellCatalog.h>

@protocol TagMediatorInput;
@class TagObjectDescriptor;

/**
 @author Golovko Mikhail
 
 Модель для отображения тегов.
 */
@interface TagModuleTableViewCellObject : NSObject <NINibCellObject, NICellObject>

@property (nonatomic, strong, readonly) TagObjectDescriptor *objectDescriptor;
@property (nonatomic, strong, readonly) id<TagMediatorInput> mediatorInput;
/**
 @author Golovko Mikhail
 
 Высота ячейки.
 */
@property (nonatomic, assign) CGFloat height;

- (instancetype)initWithObjectDescriptor:(TagObjectDescriptor *)objectDescriptor
                           mediatorInput:(id <TagMediatorInput>)mediatorInput;

+ (instancetype)objectWithObjectDescriptor:(TagObjectDescriptor *)objectDescriptor
                             mediatorInput:(id <TagMediatorInput>)mediatorInput;

@end