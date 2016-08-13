//
//  AnnouncementGalleryAnnouncementGalleryModuleInput.h
//  RamblerConferences
//
//  Created by Egor Tolstoy on 13/08/2016.
//  Copyright © 2016 Rambler&Co. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ViperMcFlurry/ViperMcFlurry.h>

@protocol AnnouncementGalleryModuleInput <RamblerViperModuleInput>

/**
 @author Egor Tolstoy

 Метод инициирует стартовую конфигурацию текущего модуля
 */
- (void)configureModule;

@end
