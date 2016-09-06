//
//  TagAssemblyTests.m
//  liveJournal
//
//  Created by Golovko Mikhail on 15/12/2015.
//  Copyright 2015 Rambler&Co. All rights reserved.
//

#import <RamblerTyphoonUtils/AssemblyTesting.h>
#import <Typhoon/Typhoon.h>
#import <RamblerTyphoonUtils/AssemblyCollector.h>

#import "TagAssembly.h"
#import "TagAssembly_Testable.h"

#import "TagPresenter.h"
#import "TagInteractor.h"
#import "TagCollectionView.h"

@interface TagAssemblyTests : RamblerTyphoonAssemblyTests

@property(strong, nonatomic) TagAssembly *assembly;

@end

@implementation TagAssemblyTests

#pragma mark - Настройка окружения для тестирования

- (void)setUp {
    [super setUp];
    
    RamblerInitialAssemblyCollector *collector = [RamblerInitialAssemblyCollector new];
    NSArray *assemblyClasses = [collector collectInitialAssemblyClasses];
    NSMutableArray *collaboratingAssemblies = [NSMutableArray array];
    for (Class assemblyClass in assemblyClasses) {
        if (assemblyClass == [TagAssembly class]) {
            continue;
        }
        TyphoonAssembly *assembly = [assemblyClass new];
        [collaboratingAssemblies addObject:assembly];
    }

    self.assembly = [[TagAssembly alloc] init];
    [self.assembly activateWithCollaboratingAssemblies:collaboratingAssemblies];
}

- (void)tearDown {
    self.assembly = nil;

    [super tearDown];
}

#pragma mark - Тестирование создания элементов модуля

- (void)testThatAssemblyCreatesCollectionView {
    // given
    Class targetClass = [TagCollectionView class];
    NSArray *dependencies = @[
            RamblerSelector(moduleInput),
            RamblerSelector(dataDisplayManager),
            RamblerSelector(cellSizeConfig)
    ];
    // when
    id result = [self.assembly collectionViewTagModule];

    // then
    [self verifyTargetDependency:result
                       withClass:targetClass
                    dependencies:dependencies];
}

- (void)testThatAssemblyCreatesPresenter {
    // given
    Class targetClass = [TagPresenter class];
    NSArray *dependencies = @[
            RamblerSelector(interactor),
            RamblerSelector(view)
    ];
    // when
    id result = [self.assembly presenterTagModule];

    // then
    [self verifyTargetDependency:result
                       withClass:targetClass
                    dependencies:dependencies];
}

- (void)testThatAssemblyCreatesInteractor {
    // given
    Class targetClass = [TagInteractor class];
    NSArray *dependencies = @[
            RamblerSelector(tagService)
    ];
    // when
    id result = [self.assembly interactorTagModule];

    // then
    [self verifyTargetDependency:result
                       withClass:targetClass
                    dependencies:dependencies];
}

- (void)testThatAssemblyCreatesDataDisplayManager {
    // given
    Class targetClass = [TagDataDisplayManager class];
    NSArray *dependencies = @[
            RamblerSelector(cellSizeCalculator)
    ];
    // when
    id result = [self.assembly dataDisplayManagerTagModule];

    // then
    [self verifyTargetDependency:result
                       withClass:targetClass
                    dependencies:dependencies];
}

@end