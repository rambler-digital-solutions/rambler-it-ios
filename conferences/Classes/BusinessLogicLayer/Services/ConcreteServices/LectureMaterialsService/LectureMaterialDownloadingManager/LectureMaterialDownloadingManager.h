//
//  LectureMaterialDownloadingManager.h
//  Conferences
//
//  Created by Konstantin Zinovyev on 03.12.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LectureMaterialDownloadingDelegate;

@interface LectureMaterialDownloadingManager : NSObject <NSURLSessionDownloadDelegate>

- (void)registerDelegate:(id)delegate forURL:(NSString *)url;
- (void)updateDelegate:(id<LectureMaterialDownloadingDelegate>)delegate forURL:(NSString *)url;

@end
