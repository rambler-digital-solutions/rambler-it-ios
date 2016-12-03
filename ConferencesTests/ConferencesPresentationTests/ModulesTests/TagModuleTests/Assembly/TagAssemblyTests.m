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

#import <RamblerTyphoonUtils/AssemblyTesting.h>
#import <Typhoon/Typhoon.h>
#import <RamblerTyphoonUtils/AssemblyCollector.h>

#import "TagAssembly.h"
#import "TagAssembly_Testable.h"

#import "TagPresenter.h"
#import "TagInteractor.h"
#import "TagCollectionView.h"

@interface TagAssemblyTests : RamblerTyphoonAssemblyTests

@property(nonatomic, strong) TagAssembly *assembly;

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
    RamblerTyphoonAssemblyTestsTypeDescriptor *descriptor = [RamblerTyphoonAssemblyTestsTypeDescriptor descriptorWithClass:targetClass];
    [self verifyTargetDependency:result withDescriptor:descriptor dependencies:dependencies];
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
    RamblerTyphoonAssemblyTestsTypeDescriptor *descriptor = [RamblerTyphoonAssemblyTestsTypeDescriptor descriptorWithClass:targetClass];
    [self verifyTargetDependency:result withDescriptor:descriptor dependencies:dependencies];
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
    RamblerTyphoonAssemblyTestsTypeDescriptor *descriptor = [RamblerTyphoonAssemblyTestsTypeDescriptor descriptorWithClass:targetClass];
    [self verifyTargetDependency:result withDescriptor:descriptor dependencies:dependencies];
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
    RamblerTyphoonAssemblyTestsTypeDescriptor *descriptor = [RamblerTyphoonAssemblyTestsTypeDescriptor descriptorWithClass:targetClass];
    [self verifyTargetDependency:result withDescriptor:descriptor dependencies:dependencies];
}

@end
