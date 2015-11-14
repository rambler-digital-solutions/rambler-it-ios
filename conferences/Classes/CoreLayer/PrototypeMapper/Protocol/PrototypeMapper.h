//
//  PrototypeMapper.h
//  Conferences
//
//  Created by Karpushin Artem on 31/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PrototypeMapper <NSObject>

- (void)fillObject:(id)filledObject
        withObject:(id)object;

@end
