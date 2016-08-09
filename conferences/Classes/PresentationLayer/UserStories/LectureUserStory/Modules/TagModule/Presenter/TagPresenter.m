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

#import "TagPresenter.h"

#import "TagViewInput.h"
#import "TagInteractorInput.h"
#import "TagModuleConfig.h"
#import "TagModuleOutput.h"
#import "TagTextFilter.h"

@interface TagPresenter ()

@property (nonatomic, strong) TagModuleConfig *moduleConfig;

@end

@implementation TagPresenter

#pragma mark - Методы TagModuleInput

- (void)configureModuleWithModuleConfig:(TagModuleConfig *)moduleConfig
                           moduleOutput:(id <TagModuleOutput>)moduleOutput {
    self.output = moduleOutput;

    self.moduleConfig = moduleConfig;

    [self.view setupInitialState];

    if (moduleConfig.verticalAlign) {
        [self.view setupVerticalContentAlign];
    } else {
        [self.view setupHorizontalContentAlign];
    }

    if (moduleConfig.enableAddButton) {
        [self.view showAddButton];
    }
    else {
        [self.view hideAddButton];
    }
    
    if (moduleConfig.enableRemoveButton) {
        [self.view enableRemoveTag];
    }
    else {
        [self.view disableRemoveTag];
    }


    [self.view setupShowNumberOfLines:moduleConfig.numberOfShowLine];

    [self updateTagsInView];
}

- (void)updateModuleWithSearchText:(NSString *)searchText {
    NSArray *tags = [self.tagFilter obtainTagsFilteredByName:searchText];
    [self.view showTags:tags];
    if (tags.count == 0) {
        if ([self.output respondsToSelector:@selector(didShowEmptyState)]) {
            [self.output didShowEmptyState];
        }
    }
}

- (void)showAddButton {
    [self.view showAddButton];
}

- (void)hideAddButton {
    [self.view hideAddButton];
}

- (void)addTagWithName:(NSString *)name {
    [self.interactor addTagWithName:name
                forObjectDescriptor:self.moduleConfig.objectDescriptor];
    [self.view appendTagWithName:name];
}

#pragma mark - Методы TagViewOutput

- (void)didTriggerTapAddButton {
    id <TagModuleOutput> output = self.output;
    if ([output respondsToSelector:@selector(didTapAddButton)]) {
        [output didTapAddButton];
    }
}

- (void)didTriggerTapTagWithName:(NSString *)name {
    id <TagModuleOutput> output = self.output;
    if ([output respondsToSelector:@selector(didTapTagWithName:)]) {
        [output didTapTagWithName:name];
    }
}

- (void)didTriggerTapRemoveTagWithName:(NSString *)name
                               atIndex:(NSInteger)index {
    [self.interactor removeTagWithName:name
                         forObjectDescriptor:self.moduleConfig.objectDescriptor];
    [self.view removeTagAtIndex:index];

    id <TagModuleOutput> output = self.output;
    if ([output respondsToSelector:@selector(didRemoveTagWithName:)]) {
        [output didRemoveTagWithName:name];
    }
}

#pragma mark - Методы TagInteractorOutput

#pragma mark - Дополнительные методы

- (void)updateTagsInView {
    NSArray *tags = [self.interactor obtainTagsFromObjectDescriptor:self.moduleConfig.objectDescriptor
                                            excludeObjectDescriptor:self.moduleConfig.filteredObjectDescriptor];

    [self.tagFilter setupTagsForFiltering:tags];

    [self.view showTags:tags];
}

@end