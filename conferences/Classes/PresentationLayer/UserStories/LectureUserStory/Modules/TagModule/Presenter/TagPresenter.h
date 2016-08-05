//
//  TagPresenter.h
//  liveJournal
//
//  Created by Golovko Mikhail on 15/12/2015.
//  Copyright 2015 Rambler&Co. All rights reserved.
//

#import "TagViewOutput.h"
#import "TagModuleInput.h"

@protocol TagViewInput;
@protocol TagInteractorInput;
@class TagTextFilter;

@interface TagPresenter : NSObject <TagModuleInput, TagViewOutput>

@property (nonatomic, weak) id<TagViewInput> view;
@property (nonatomic, strong) id<TagInteractorInput> interactor;
@property (nonatomic, weak) id<TagModuleOutput> output;
@property (nonatomic, strong) TagTextFilter *tagFilter;

@end