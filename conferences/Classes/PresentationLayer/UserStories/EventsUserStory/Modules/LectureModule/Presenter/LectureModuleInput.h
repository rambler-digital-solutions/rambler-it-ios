//
//  LectureModuleInput.h
//  Conferences
//
//  Created by Karpushin Artem on 06/01/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LectureModuleInput <NSObject>

/**
 @author Artem Karpushin
 
 Method is used to cunfigure lecture module
 
 @param objectId Lecture object id
 */
- (void)configureCurrentModuleWithLectureObjectId:(NSString *)objectId;

@end
