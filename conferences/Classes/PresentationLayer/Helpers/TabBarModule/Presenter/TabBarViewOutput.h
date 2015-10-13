
#import <Foundation/Foundation.h>

@protocol TabBarViewOutput <NSObject>

- (void)setupView;
- (void)selectedTabWithIndex:(NSUInteger)tabIndex;

@end

