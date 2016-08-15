//
//  TransformationJSON.h
//  Conferences
//
//  Created by k.zinovyev on 15.08.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 @author Egor Tolstoy
 
 This protocol describes an object that is responsible for mapping NSDictionary with contents of resource file to a model object.
 */
@protocol ResponseConverter <NSObject>

- (NSDictionary *)convertFromResponse:(NSDictionary *)dict;

@end