//
//  LectureMaterialDownloadingManager_Testable.h
//  Conferences
//
//  Created by k.zinovyev on 19.12.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import "LectureMaterialDownloadingManager.h"

@interface LectureMaterialDownloadingManager ()

@property (nonatomic, strong) NSMapTable<NSString *, id <NSURLSessionDownloadDelegate>> *delegatesByIdentifier;

@end
