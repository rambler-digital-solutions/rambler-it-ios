//
// TagEditMediator.m
// LiveJournal
// 
// Created by Golovko Mikhail on 21/12/15.
// Copyright © 2015 Rambler&Co. All rights reserved.
//

#import "TagEditMediator.h"
#import "TagEditMediatorOutput.h"
#import "TagModuleInput.h"
#import "TagObjectDescriptor.h"
#import "TagModuleConfig.h"

@interface TagEditMediator ()

@property (nonatomic, strong) TagObjectDescriptor *editedObjectDescriptor;
@property (nonatomic, strong) TagObjectDescriptor *suggestObjectDescriptor;

/**
 @author Golovko Mikhail

 Input модуля выбора тега.
 */
@property (nonatomic, strong) id<TagChooseModuleInput> tagChooseInput;

/**
 @author Golovko Mikhail

 Input модуля отображения тегов.
 */
@property (nonatomic, strong) id<TagModuleInput> tagInput;


@end

@implementation TagEditMediator

#pragma mark - методы TagChooseModuleOutput

- (void)didAddTagWithName:(NSString *)name {
    [self.tagInput addTagWithName:name];
}

- (void)didTriggerEndChooseTag {
    [self.tagInput showAddButton];
    [self.output hideChooseTagModule];
}

#pragma mark - методы TagModuleOutput

- (void)didTapAddButton {
    [self.tagInput hideAddButton];
    [self.output showChooseTagModule];
    [self.tagChooseInput showModule];
}

- (void)didRemoveTagWithName:(NSString *)name {
    [self.tagChooseInput invalidateData];
}

#pragma mark - Методы TagMediatorInput

- (void)configureWithObjectDescriptor:(TagObjectDescriptor *)objectDescriptor
                       tagModuleInput:(id <TagModuleInput>)tagModuleInput {

    self.tagInput = tagModuleInput;
    self.editedObjectDescriptor = objectDescriptor;
    
    TagModuleConfig *moduleConfig = [[TagModuleConfig alloc] initWithObjectDescriptor:objectDescriptor];
    moduleConfig.verticalAlign = YES;
    moduleConfig.enableAddButton = YES;
    moduleConfig.enableRemoveButton = YES;
    [self.tagInput configureModuleWithModuleConfig:moduleConfig
                                      moduleOutput:self];
    [self configureChooseInputIfNeeded];
}

#pragma mark - Методы TagEditMediatorInput

- (void)configureModuleWithChooseModuleInput:(id <TagChooseModuleInput>)tagChooseModuleInput {
    self.tagChooseInput = tagChooseModuleInput;
}

- (void)updateWithSuggestObjectDescriptor:(TagObjectDescriptor *)objectDescriptor {
    self.suggestObjectDescriptor = objectDescriptor;
    [self configureChooseInputIfNeeded];
}

#pragma mark - Дополнительные методы

- (void)configureChooseInputIfNeeded {

    if (self.editedObjectDescriptor == nil
            || self.suggestObjectDescriptor == nil) {
        return;
    }

    TagChooseModuleConfig *moduleConfig = [[TagChooseModuleConfig alloc] initWithEditedObjectDescriptor:self.editedObjectDescriptor
                                                                                suggestObjectDescriptor:self.suggestObjectDescriptor];
    [self.tagChooseInput configureModuleWithOutputModuleConfig:moduleConfig
                                                  moduleOutput:self];
}

@end