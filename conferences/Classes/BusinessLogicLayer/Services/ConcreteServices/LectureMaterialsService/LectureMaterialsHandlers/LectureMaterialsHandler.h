//
//  LectureMaterialsHandlers.h
//  Conferences
//
//  Created by k.zinovyev on 19.11.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

@class LectureMaterialPlainObject;

typedef void (^LectureMaterialCompletionBlock)(NSString *localUrl, NSError *error);

@protocol LectureMaterialsHandler <NSObject>

- (BOOL)canHandleLectureMaterial:(LectureMaterialPlainObject *)lectureMaterial;

- (id)obtainFromCacheLectureMaterial:(LectureMaterialPlainObject *)lectureMaterial;

- (void)downloadToCacheLectureMaterial:(LectureMaterialPlainObject *)lectureMaterial
                              delegate:(id<NSURLSessionDownloadDelegate>)delegate
                            completion:(LectureMaterialCompletionBlock)completionBlock;

- (void)removeFromCacheLectureMaterial:(LectureMaterialPlainObject *)lectureMaterial
                            completion:(LectureMaterialCompletionBlock)completionBlock ;

@end
