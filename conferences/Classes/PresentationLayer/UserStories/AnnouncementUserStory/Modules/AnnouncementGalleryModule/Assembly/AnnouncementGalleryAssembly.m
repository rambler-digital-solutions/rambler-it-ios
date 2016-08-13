//
//  AnnouncementGalleryAnnouncementGalleryAssembly.m
//  RamblerConferences
//
//  Created by Egor Tolstoy on 13/08/2016.
//  Copyright © 2016 Rambler&Co. All rights reserved.
//

#import "AnnouncementGalleryAssembly.h"

#import "AnnouncementGalleryViewController.h"
#import "AnnouncementGalleryInteractor.h"
#import "AnnouncementGalleryPresenter.h"
#import "AnnouncementGalleryRouter.h"

#import <ViperMcFlurry/ViperMcFlurry.h>

@implementation AnnouncementGalleryAssembly

- (AnnouncementGalleryViewController *)viewAnnouncementGalleryModule {
    return [TyphoonDefinition withClass:[AnnouncementGalleryViewController class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(output)
                                                    with:[self presenterAnnouncementGalleryModule]];
                              [definition injectProperty:@selector(moduleInput)
                                                    with:[self presenterAnnouncementGalleryModule]];
                          }];
}

- (AnnouncementGalleryInteractor *)interactorAnnouncementGalleryModule {
    return [TyphoonDefinition withClass:[AnnouncementGalleryInteractor class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(output)
                                                    with:[self presenterAnnouncementGalleryModule]];
                          }];
}

- (AnnouncementGalleryPresenter *)presenterAnnouncementGalleryModule {
    return [TyphoonDefinition withClass:[AnnouncementGalleryPresenter class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(view)
                                                    with:[self viewAnnouncementGalleryModule]];
                              [definition injectProperty:@selector(interactor)
                                                    with:[self interactorAnnouncementGalleryModule]];
                              [definition injectProperty:@selector(router)
                                                    with:[self routerAnnouncementGalleryModule]];
                          }];
}

- (AnnouncementGalleryRouter *)routerAnnouncementGalleryModule {
    return [TyphoonDefinition withClass:[AnnouncementGalleryRouter class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(transitionHandler)
                                                    with:[self viewAnnouncementGalleryModule]];
                          }];
}

@end
