//
//  LectureMaterialCache.h
//  Conferences
//
//  Created by k.zinovyev on 19.11.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

@class LectureMaterialViewModel;

@protocol LectureMaterialCacheDelegate <NSObject>

- (void)didTapRemoveFromCacheLectureMaterial:(LectureMaterialViewModel *)lectureMaterial;

- (void)didTapDownloadToCacheLectureMaterial:(LectureMaterialViewModel *)lectureMaterial;

@end
