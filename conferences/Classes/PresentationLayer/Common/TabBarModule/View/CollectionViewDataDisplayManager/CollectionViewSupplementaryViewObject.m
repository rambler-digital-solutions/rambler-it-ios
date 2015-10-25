
#import "CollectionViewSupplementaryViewObject.h"

@implementation CollectionViewSupplementaryViewObject

-(NSString*)supplementaryViewReuseId {
    return NSStringFromClass([self supplementaryViewClass]);
}

- (Class)supplementaryViewClass {
    return nil;
}

@end
