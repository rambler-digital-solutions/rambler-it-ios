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

@interface SpeakerInfoDataDisplayManager : NSObject <DataDisplayManager, UITableViewDelegate>

- (void)configureDataDisplayManagerWithSpeaker:(SpeakerPlainObject *)speaker;

@end
