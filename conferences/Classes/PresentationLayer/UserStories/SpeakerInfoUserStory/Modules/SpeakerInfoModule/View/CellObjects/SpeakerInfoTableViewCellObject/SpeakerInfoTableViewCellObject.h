//
//  SpeakerInfoTableViewCellObject.h
//  Conferences
//
//  Created by Karpushin Artem on 20/03/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Nimbus/NimbusModels.h>

@interface SpeakerInfoTableViewCellObject : NSObject <NICellObject>

@property (strong, nonatomic, readonly) NSString *text;

+ (instancetype)objectWithText:(NSString *)text;

@end
