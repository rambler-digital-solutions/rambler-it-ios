//
//  SpotlightImageModel.m
//  Conferences
//
//  Created by k.zinovyev on 20.12.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import "SpotlightImageModel.h"

@implementation SpotlightImageModel

- (instancetype)initWithEntityId:(NSString *)entityId
                       imageLink:(NSString *)imageLink {
    self = [super init];
    
    if (self) {
        _entityId = entityId;
        _imageLink = imageLink;
    }
    
    return self;
}

@end
