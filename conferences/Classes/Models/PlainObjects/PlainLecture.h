//
//  PlainLecture.h
//  Conferences
//
//  Created by Karpushin Artem on 15/11/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlainLecture : NSObject

// пока окончательно не сформирована модель данных - все проперти readwrite

@property (strong, nonatomic, readwrite) NSNumber *favourite;
@property (strong, nonatomic, readwrite) NSString *name;
@property (strong, nonatomic, readwrite) NSNumber *orderID;
@property (strong, nonatomic, readwrite) NSString *slideLink;
@property (strong, nonatomic, readwrite) NSString *lectureDescription;
@property (strong, nonatomic, readwrite) NSString *videoLink;
@property (strong, nonatomic, readwrite) NSArray *lectureMaterials;
@property (strong, nonatomic, readwrite) NSArray *speakers;

@end
