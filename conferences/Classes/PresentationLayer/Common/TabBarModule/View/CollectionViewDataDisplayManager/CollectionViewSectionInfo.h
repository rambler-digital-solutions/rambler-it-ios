
#import <Foundation/Foundation.h>

@protocol CollectionViewSupplementaryViewObjectProtocol;

@interface CollectionViewSectionInfo : NSObject

@property (nonatomic,strong,readonly) id<CollectionViewSupplementaryViewObjectProtocol> headerObject;
@property (nonatomic,strong,readonly) id<CollectionViewSupplementaryViewObjectProtocol> footerObject;
@property (nonatomic,strong,readonly) NSArray* cellObjects;

- (instancetype)initWithHeaderObject:(id<CollectionViewSupplementaryViewObjectProtocol>)headerObject
                        footerObject:(id<CollectionViewSupplementaryViewObjectProtocol>)footerObject
              andFlatListCellObjects:(NSArray*)cellObjects;

@end
