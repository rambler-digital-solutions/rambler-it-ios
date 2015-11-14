
#import <UIKit/UIKit.h>
#import "ModuleTransitionHandlerProtocol.h"

// TODO#18: Удалить
@interface UIViewController (DefaultTransitionHandling)

- (id<ModuleConfigurationPromiseProtocol>)default_performPromiseSegue:(NSString*)segueIdentifier withSender:(id)sender;
- (void)default_embedViewController:(UIViewController*)viewController;
- (void)default_prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;

@end
