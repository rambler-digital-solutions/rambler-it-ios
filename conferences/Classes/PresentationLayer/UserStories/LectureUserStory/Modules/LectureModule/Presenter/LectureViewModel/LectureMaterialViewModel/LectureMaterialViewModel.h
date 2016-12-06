//
//  LectureMaterialViewModel.h
//  Conferences
//
//  Created by k.zinovyev on 06.12.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LectureMaterialViewModel : NSObject

@property (nonatomic, copy) NSString *lectureMaterialId;
@property (nonatomic, copy) NSString *link;
@property (nonatomic, copy) NSString *localURL;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSNumber *type;

@property (nonatomic, copy) NSNumber *percent;
@property (nonatomic, copy) NSNumber *isDownloading;

@end
