//
//  SpeakerInfoDataDisplayManager.h
//  Conferences
//
//  Created by Karpushin Artem on 16/01/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataDisplayManager.h"

@class SpeakerPlainObject;
@class SpeakerInfoCellObjectsBuilder;

@interface SpeakerInfoDataDisplayManager : NSObject <DataDisplayManager, UITableViewDelegate>

@property (nonatomic, strong) SpeakerInfoCellObjectsBuilder *cellObjectBuilder;

- (void)configureDataDisplayManagerWithSpeaker:(SpeakerPlainObject *)speaker;

@end
