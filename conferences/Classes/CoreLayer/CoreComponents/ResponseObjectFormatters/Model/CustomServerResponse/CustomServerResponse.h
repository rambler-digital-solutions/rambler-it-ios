//
//  CustomServerResponse.h
//  Conferences
//
//  Created by k.zinovyev on 15.08.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomServerResponse : NSObject

@property (nonatomic, strong) NSArray *deletedObjects;
@property (nonatomic, strong) NSArray *updatedObjects;

@end
