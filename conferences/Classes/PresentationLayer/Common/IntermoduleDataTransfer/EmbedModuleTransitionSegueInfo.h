
#import "ModuleTransitionSegueInfo.h"

@interface EmbedModuleTransitionSegueInfo : ModuleTransitionSegueInfo

@property (nonatomic,strong,readonly) UIView *containerView;

- (instancetype)initWithSender:(id)sender andPromise:(id<ModuleConfigurationPromiseProtocol>)promise andContainerView:(UIView*)containerView;

@end
