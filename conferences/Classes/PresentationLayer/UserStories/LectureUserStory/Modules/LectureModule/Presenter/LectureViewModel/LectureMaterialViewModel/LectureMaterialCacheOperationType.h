//
//  LectureMaterialCacheOperationType.h
//  Conferences
//
//  Created by Konstantin Zinovyev on 10.12.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

typedef NS_ENUM(NSUInteger, LectureMaterialCacheOperationType) {
    LectureMaterialStartDownloadType = 1,
    LectureMaterialDownloadType = 2,
    LectureMaterialEndDownloadType = 3,
    LectureMaterialRemoveType = 4
};
