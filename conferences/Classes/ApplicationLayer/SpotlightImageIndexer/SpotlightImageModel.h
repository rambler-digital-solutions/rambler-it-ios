//
//  SpotlightImageModel.h
//  Conferences
//
//  Created by k.zinovyev on 20.12.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SpotlightImageModel : NSObject

@property (nonatomic, copy) NSString *entityId;
@property (nonatomic, copy) NSString *imageLink;

- (instancetype)initWithEntityId:(NSString *)entityId
                       imageLink:(NSString *)imageLink;

@end
