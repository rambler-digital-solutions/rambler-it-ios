
#import <UIKit/UIKit.h>

@protocol ModuleConfigurationPromiseProtocol;

@interface ModuleTransitionSegueInfo : NSObject

@property (nonatomic,strong,readonly) id sender;
@property (nonatomic,strong,readonly) id<ModuleConfigurationPromiseProtocol> promise;

- (instancetype)initWithSender:(id)sender andPromise:(id<ModuleConfigurationPromiseProtocol>)promise;

@end
