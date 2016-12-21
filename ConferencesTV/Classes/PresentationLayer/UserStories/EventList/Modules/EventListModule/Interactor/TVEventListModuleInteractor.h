//
//  TVEventListModuleTVEventListModuleInteractor.h
//  Conferences
//
//  Created by Porokhov Artem on 21/12/2016.
//  Copyright © 2016 Rambler&Co. All rights reserved.
//

#import "TVEventListModuleInteractorInput.h"

@protocol TVEventListModuleInteractorOutput;

@interface TVEventListModuleInteractor : NSObject <TVEventListModuleInteractorInput>

@property (nonatomic, weak) id<TVEventListModuleInteractorOutput> output;

@end
