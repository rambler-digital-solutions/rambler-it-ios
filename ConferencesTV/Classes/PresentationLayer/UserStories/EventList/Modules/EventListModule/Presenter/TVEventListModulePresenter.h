//
//  TVEventListModuleTVEventListModulePresenter.h
//  Conferences
//
//  Created by Porokhov Artem on 21/12/2016.
//  Copyright © 2016 Rambler&Co. All rights reserved.
//

#import "TVEventListModuleViewOutput.h"
#import "TVEventListModuleInteractorOutput.h"
#import "TVEventListModuleModuleInput.h"

@protocol TVEventListModuleViewInput;
@protocol TVEventListModuleInteractorInput;
@protocol TVEventListModuleRouterInput;

@interface TVEventListModulePresenter : NSObject <TVEventListModuleModuleInput, TVEventListModuleViewOutput, TVEventListModuleInteractorOutput>

@property (nonatomic, weak) id<TVEventListModuleViewInput> view;
@property (nonatomic, strong) id<TVEventListModuleInteractorInput> interactor;
@property (nonatomic, strong) id<TVEventListModuleRouterInput> router;

@end
