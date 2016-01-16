//
//  LectureDescriptionTableViewCellObject.h
//  Conferences
//
//  Created by Karpushin Artem on 16/01/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Nimbus/NimbusModels.h>

@class LecturePlainObject;

@interface LectureDescriptionTableViewCellObject : NSObject <NICellObject>

@property (strong, nonatomic, readonly) NSString *dateString;
@property (strong, nonatomic, readonly) NSString *lectureTitle;
@property (strong, nonatomic, readonly) NSString *lectureDescription;

+ (instancetype)objectWithLecture:(LecturePlainObject *)lecture andDate:(NSString *)date;

@end
