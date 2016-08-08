//
//  TagAssembly.m
//  liveJournal
//
//  Created by Golovko Mikhail on 15/12/2015.
//  Copyright 2015 Rambler&Co. All rights reserved.
//

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
#import "TagTextFilter.h"
#import "ServiceComponents.h"

@implementation TagAssembly

- (TagCollectionView *)collectionViewTagModule {
    return [TyphoonDefinition withClass:[TagCollectionView class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition useInitializer:@selector(collectionView)];
                              [definition injectProperty:@selector(moduleInput)
                                                    with:[self presenterTagModule]];
                              [definition injectProperty:@selector(output)
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
                              [definition injectProperty:@selector(tagFilter)
                                                    with:[self tagTextFilterTagModule]];
                          }];
}

- (TagDataDisplayManager *)dataDisplayManagerTagModule {
    return [TyphoonDefinition withClass:[TagDataDisplayManager class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(cellSizeCalculator)
                                                    with:[self tagCellSizeCalculatorTagModule]];
                              [definition injectProperty:@selector(delegate)
                                                    with:[self collectionViewTagModule]];
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

- (TagTextFilter *)tagTextFilterTagModule {
    return [TyphoonDefinition withClass:[TagTextFilter class]];
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