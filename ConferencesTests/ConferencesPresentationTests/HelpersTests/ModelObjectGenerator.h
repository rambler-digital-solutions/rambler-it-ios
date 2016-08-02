//
//  ModelObjectGenerator.h
//  Conferences
//
//  Created by Vasyura Anastasiya on 29/07/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EventPlainObject;
@class LecturePlainObject;

@interface ModelObjectGenerator : NSObject

+ (NSArray *)generateEventObjects:(NSInteger)count;
+ (NSArray *)generateLectureObjects:(NSInteger)count;

@end
