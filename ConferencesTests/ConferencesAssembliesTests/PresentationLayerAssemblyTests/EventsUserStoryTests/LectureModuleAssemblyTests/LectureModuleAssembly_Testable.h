//
//  LectureModuleAssembly_Testable.h
//  Conferences
//
//  Created by Karpushin Artem on 26/03/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import "LectureModuleAssembly.h'

@class LectureViewController;
@class LectureInteractor;
@class LecturePresenter;
@class LectureRouter;
@class LecturePresenterStateStorage;
@class LectureDataDisplayManager;

@interface LectureModuleAssembly ()

- (LectureViewController *)viewLecture;
- (LectureInteractor *)interactorLecture;
- (LecturePresenter *)presenterLecture;
- (LectureRouter *)routerLecture;
- (LecturePresenterStateStorage *)presenterStateStorageLecture;
- (LectureDataDisplayManager *)dataDisplayManagerLecture

@end
