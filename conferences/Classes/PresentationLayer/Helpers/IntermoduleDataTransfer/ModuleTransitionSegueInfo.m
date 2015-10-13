
#import "ModuleTransitionSegueInfo.h"

@interface ModuleTransitionSegueInfo()

@property (nonatomic,strong) id sender;
@property (nonatomic,strong) id<ModuleConfigurationPromiseProtocol> promise;

@end

@implementation ModuleTransitionSegueInfo

- (instancetype)initWithSender:(id)sender andPromise:(id<ModuleConfigurationPromiseProtocol>)promise {
    self = [super init];
    if (self) {
        self.sender = sender;
        self.promise = promise;
    }
    return self;
}

@end
