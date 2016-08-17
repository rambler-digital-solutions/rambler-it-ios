// Copyright (c) 2015 RAMBLER&Co
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

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
//    [self.tagChooseInput showModule];
}

- (void)didRemoveTagWithName:(NSString *)name {
//    [self.tagChooseInput invalidateData];
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

//    TagChooseModuleConfig *moduleConfig = [[TagChooseModuleConfig alloc] initWithEditedObjectDescriptor:self.editedObjectDescriptor
//                                                                                suggestObjectDescriptor:self.suggestObjectDescriptor];
//    [self.tagChooseInput configureModuleWithOutputModuleConfig:moduleConfig
//                                                  moduleOutput:self];
}

@end