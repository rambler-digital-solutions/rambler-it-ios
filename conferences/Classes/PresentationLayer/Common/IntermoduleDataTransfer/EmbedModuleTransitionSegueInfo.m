
#import "EmbedModuleTransitionSegueInfo.h"

@interface EmbedModuleTransitionSegueInfo()

@property (nonatomic,strong) UIView *containerView;

@end

@implementation EmbedModuleTransitionSegueInfo

- (instancetype)initWithSender:(id)sender andPromise:(id<ModuleConfigurationPromiseProtocol>)promise andContainerView:(UIView*)containerView {
    self = [super initWithSender:sender andPromise:promise];
    if (self) {
        self.containerView = containerView;
    }
    return self;
}

@end
