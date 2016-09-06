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

#import "TagAssembly.h"

#import "TagInteractor.h"
#import "TagPresenter.h"
#import "TagCollectionView.h"
#import "TagDataDisplayManager.h"
#import "TagCellSizeCalculator.h"
#import "TagModuleTableViewCell.h"
#import "ContentSizeObserver.h"
#import "TagCellSizeConfig.h"
#import "TagCellSizeRowCalculator.h"
#import "ServiceComponents.h"

@implementation TagAssembly

- (TagCollectionView *)collectionViewTagModule {
    return [TyphoonDefinition withClass:[TagCollectionView class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition useInitializer:@selector(collectionView)];
                              [definition injectProperty:@selector(moduleInput)
                                                    with:[self presenterTagModule]];
                              [definition injectProperty:@selector(dataDisplayManager)
                                                    with:[self dataDisplayManagerTagModule]];
                              [definition injectProperty:@selector(cellSizeConfig)
                                                    with:[self tagCellSizeConfigTagModule]];
                          }];
}

- (TagInteractor *)interactorTagModule {
    return [TyphoonDefinition withClass:[TagInteractor class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(tagService)
                                                    with:[self.serviceComponents tagService]];
                          }];
}

- (TagPresenter *)presenterTagModule {
    return [TyphoonDefinition withClass:[TagPresenter class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(view)
                                                    with:[self collectionViewTagModule]];
                              [definition injectProperty:@selector(interactor)
                                                    with:[self interactorTagModule]];
                          }];
}

- (TagDataDisplayManager *)dataDisplayManagerTagModule {
    return [TyphoonDefinition withClass:[TagDataDisplayManager class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(cellSizeCalculator)
                                                    with:[self tagCellSizeCalculatorTagModule]];
                          }];
}

- (TagCellSizeCalculator *)tagCellSizeCalculatorTagModule {
    return [TyphoonDefinition withClass:[TagCellSizeCalculator class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition useInitializer:@selector(initWithRowCalculator:config:)
                                              parameters:^(TyphoonMethod *initializer) {
                                                  [initializer injectParameterWith:[self tagCellSizeRowCalculatorTagModule]];
                                                  [initializer injectParameterWith:[self tagCellSizeConfigTagModule]];
                                              }];
                          }];
}

- (TagCellSizeRowCalculator *)tagCellSizeRowCalculatorTagModule {
    return [TyphoonDefinition withClass:[TagCellSizeRowCalculator class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition useInitializer:@selector(initWithConfig:)
                                              parameters:^(TyphoonMethod *initializer) {
                                                  [initializer injectParameterWith:[self tagCellSizeConfigTagModule]];
                                              }];
                          }];
}

- (TagCellSizeConfig *)tagCellSizeConfigTagModule {
    return [TyphoonDefinition withClass:[TagCellSizeConfig class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition useInitializer:@selector(defaultConfig)];
                          }];
}

#pragma mark - Для ячейки

- (TagModuleTableViewCell *)tagCellNewPostModule {
    return [TyphoonDefinition withClass:[TagModuleTableViewCell class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(sizeObserver)
                                                    with:[self contentSizeObserverNewPostModule]];
                          }];
}

- (ContentSizeObserver *)contentSizeObserverNewPostModule {
    return [TyphoonDefinition withClass:[ContentSizeObserver class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(delegate)
                                                    with:[self tagCellNewPostModule]];
                          }];
}

@end