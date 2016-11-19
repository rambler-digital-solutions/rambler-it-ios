//
//  LectureMaterialCache.h
//  Conferences
//
//  Created by k.zinovyev on 19.11.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

@class LectureMaterialPlainObject;

@protocol LectureMaterialCacheDelegate <NSObject>

- (void)didTapRemoveFromCacheLectureMaterial:(LectureMaterialPlainObject *)lectureMaterial;

- (void)didTapDownloadToCacheLectureMaterial:(LectureMaterialPlainObject *)lectureMaterial;

@end
