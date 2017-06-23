# How to use CDProxy
~~~objectivec
#import <UIViewController+CDObserver.h>

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self cd_startObserveProtocol:@protocol(TableViewCellDelegate)];
}

- (void)didSwitch:(id)sender {

}

@end
~~~
~~~objectivec
#import "UIResponder+CDProxying.h"

@interface TableViewCell ()

@property (weak, nonatomic) id<TableViewCellDelegate> actionProxy;

@end

@implementation TableViewCell

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    self.actionProxy = (id<TableViewCellDelegate>)[self cd_proxyForProtocol:@protocol(TableViewCellDelegate)];
}

- (IBAction)switchAction:(id)sender {
    
    [self.actionProxy didSwitch:sender];
    
}

@end
~~~
