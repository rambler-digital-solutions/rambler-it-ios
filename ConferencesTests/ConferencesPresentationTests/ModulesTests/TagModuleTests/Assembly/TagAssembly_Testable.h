//
//  TagAssembly_Testable.h
//  liveJournal
//
//  Created by Golovko Mikhail on 15/12/2015.
//  Copyright 2015 Rambler&Co. All rights reserved.
//

#import "TagAssembly.h"

@class TagInteractor;
@class TagPresenter;
@class TagCollectionView;
@class TagDataDisplayManager;

@interface TagAssembly ()

- (TagCollectionView *)collectionViewTagModule;
- (TagPresenter *)presenterTagModule;
- (TagInteractor *)interactorTagModule;
- (TagDataDisplayManager *)dataDisplayManagerTagModule;

@end