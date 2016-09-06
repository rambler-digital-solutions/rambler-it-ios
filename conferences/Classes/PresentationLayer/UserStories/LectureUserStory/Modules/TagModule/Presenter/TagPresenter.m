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

    [self.view setupShowNumberOfLines:moduleConfig.numberOfShowLine];

    [self updateTagsInView];
}

#pragma mark - Дополнительные методы

- (void)updateTagsInView {
    NSArray *tags = [self.interactor obtainTagsFromObjectDescriptor:self.moduleConfig.objectDescriptor
                                            excludeObjectDescriptor:self.moduleConfig.filteredObjectDescriptor];

    [self.view showTags:tags];
}

@end