
#import "CollectionViewSectionInfo.h"

@interface CollectionViewSectionInfo ()

@property (nonatomic,strong) id<CollectionViewSupplementaryViewObjectProtocol> headerObject;
@property (nonatomic,strong) id<CollectionViewSupplementaryViewObjectProtocol> footerObject;
@property (nonatomic,strong) NSArray* cellObjects;

@end

@implementation CollectionViewSectionInfo

- (instancetype)initWithHeaderObject:(id<CollectionViewSupplementaryViewObjectProtocol>)headerObject
                        footerObject:(id<CollectionViewSupplementaryViewObjectProtocol>)footerObject
              andFlatListCellObjects:(NSArray *)cellObjects {
    
    self = [super init];
    if (self) {
        self.headerObject = headerObject;
        self.footerObject = footerObject;
        self.cellObjects = cellObjects;
    }
    return self;
}

@end
