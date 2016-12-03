//
//  LectureMaterialDownloadingManager.h
//  Conferences
//
//  Created by Konstantin Zinovyev on 03.12.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LectureMaterialDownloadingManager : NSObject <NSURLSessionDownloadDelegate>

- (void)updateDelegate:(id<NSURLSessionDownloadDelegate>)delegate forURL:(NSString *)url;

@end
