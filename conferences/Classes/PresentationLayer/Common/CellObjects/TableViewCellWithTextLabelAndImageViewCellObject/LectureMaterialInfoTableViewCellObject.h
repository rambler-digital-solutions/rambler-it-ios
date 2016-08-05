//
//  TableViewCellWithTextLabelAndImageViewCellObject.h
//  Conferences
//
//  Created by Karpushin Artem on 16/01/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Nimbus/NimbusModels.h>

@interface LectureMaterialInfoTableViewCellObject : NSObject <NICellObject>

@property (strong, nonatomic, readonly) UIImage *image;
@property (strong, nonatomic, readonly) NSString *text;

+ (instancetype)objectWithText:(NSString *)text andImage:(UIImage *)image;

@end
