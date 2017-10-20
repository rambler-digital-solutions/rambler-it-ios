//
//  TagModelObjectMock.h
//  ConferencesTests
//
//  Created by a.yakimenko on 16.10.2017.
//  Copyright © 2017 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TagModelObjectMock : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *slug;
@property (nonatomic, copy) NSString *tagId;
@property (nonatomic, strong) NSSet *lectures;

@end
