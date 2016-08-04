//
//  SpeakerInfoSectionHeaderCellObject.h
//  Conferences
//
//  Created by Vasyura Anastasiya on 04/08/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Nimbus/NimbusModels.h>

@interface SpeakerInfoSectionHeaderCellObject : NSObject <NICellObject>

@property (nonatomic, strong) NSString *text;

+ (instancetype)objectWithText:(NSString *)text;

@end
