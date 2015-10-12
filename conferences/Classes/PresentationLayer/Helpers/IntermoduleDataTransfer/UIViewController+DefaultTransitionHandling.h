//
//  UIViewController+DefaultTransitionHandling.h
//  Championat
//
//  Created by Andrey Zarembo-Godzyatsky on 03/08/15.
//  Copyright (c) 2015 Rambler DS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RDSModuleTransitionHandlerProtocol.h"

// TODO#18: Удалить
@interface UIViewController (DefaultTransitionHandling)

- (id<RDSModuleConfigurationPromiseProtocol>)default_performPromiseSegue:(NSString*)segueIdentifier withSender:(id)sender;
- (void)default_embedViewController:(UIViewController*)viewController;
- (void)default_prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;

@end
