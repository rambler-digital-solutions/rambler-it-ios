//
//  TagInteractor.h
//  liveJournal
//
//  Created by Golovko Mikhail on 15/12/2015.
//  Copyright 2015 Rambler&Co. All rights reserved.
//

#import "TagInteractorInput.h"

@protocol TagService;

@interface TagInteractor : NSObject <TagInteractorInput>

@property (nonatomic, strong) id<TagService> tagService;

@end