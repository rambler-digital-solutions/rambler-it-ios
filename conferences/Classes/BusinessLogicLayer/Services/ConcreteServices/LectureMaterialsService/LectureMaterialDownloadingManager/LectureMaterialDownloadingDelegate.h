//
//  LectureMaterialDownloadingDelegate.h
//  Conferences
//
//  Created by k.zinovyev on 06.12.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

@protocol LectureMaterialDownloadingDelegate <NSURLSessionDownloadDelegate>

- (void)didStartDownloadingLectureMaterialWithLink:(NSString *)link;

@end
