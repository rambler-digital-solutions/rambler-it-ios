// Copyright (c) 2016 RAMBLER&Co
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

#import "LectureModuleAssembly.h"
#import "LectureViewController.h"
#import "LectureInteractor.h"
#import "LecturePresenter.h"
#import "LectureRouter.h"
#import "LectureDataDisplayManager.h"
#import "LecturePresenterStateStorage.h"
#import "PresentationLayerHelpersAssembly.h"
#import "ServiceComponents.h"
#import "LectureCellObjectsBuilderImplementation.h"

@implementation  LectureModuleAssembly

- (LectureViewController *)viewLecture {
    return [TyphoonDefinition withClass:[LectureViewController class]
                            configuration:^(TyphoonDefinition *definition) {
                                [definition injectProperty:@selector(output)
                                                      with:[self presenterLecture]];
                                [definition injectProperty:@selector(dataDisplayManager)
                                                      with:[self dataDisplayManagerLecture]];
             }];
}

- (LectureInteractor *)interactorLecture {
    return [TyphoonDefinition withClass:[LectureInteractor class]
                            configuration:^(TyphoonDefinition *definition) {
                                [definition injectProperty:@selector(output)
                                                      with:[self presenterLecture]];
                                [definition injectProperty:@selector(ponsomizer)
                                                      with:[self.ponsomizerAssembly ponsomizer]];
                                [definition injectProperty:@selector(lectureService)
                                                      with:[self.serviceComponents lectureService]];
             }];
}

- (LecturePresenter *)presenterLecture {
    return [TyphoonDefinition withClass:[LecturePresenter class]
                            configuration:^(TyphoonDefinition *definition) {
                                [definition injectProperty:@selector(view)
                                                      with:[self viewLecture]];
                                [definition injectProperty:@selector(interactor)
                                                      with:[self interactorLecture]];
                                [definition injectProperty:@selector(router)
                                                      with:[self routerLecture]];
                                [definition injectProperty:@selector(stateStorage)
                                                      with:[self presenterStateStorageLecture]];
            }];
}

- (LectureRouter *)routerLecture {
    return [TyphoonDefinition withClass:[LectureRouter class]
                            configuration:^(TyphoonDefinition *definition) {
                                [definition injectProperty:@selector(transitionHandler)
                                                      with:[self viewLecture]];
                                [definition injectProperty:@selector(safariFactory)
                                                      with:[self.presentationLayerHelpersAssembly safariFactory]];
           }];
}

- (LecturePresenterStateStorage *)presenterStateStorageLecture {
    return [TyphoonDefinition withClass:[LecturePresenterStateStorage class]];
}

- (LectureDataDisplayManager *)dataDisplayManagerLecture {
    return [TyphoonDefinition withClass:[LectureDataDisplayManager class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(builderCellObjects)
                                                    with:[self builderCellObjects]];
                              [definition injectProperty:@selector(delegate)
                                                    with:[self viewLecture]];
            }];
}

- (LectureCellObjectsBuilderImplementation *)builderCellObjects {
    return [TyphoonDefinition withClass:[LectureCellObjectsBuilderImplementation class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(thumbnailGenerator)
                                                    with:[self.presentationLayerHelpersAssembly videoThumbnailGenerator]];
                          }];
}

@end