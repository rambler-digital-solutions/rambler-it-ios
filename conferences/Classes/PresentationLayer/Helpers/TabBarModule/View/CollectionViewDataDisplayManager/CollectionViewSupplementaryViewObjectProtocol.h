
#import <Foundation/Foundation.h>

@protocol CollectionViewSupplementaryViewObjectProtocol <NSObject>

-(NSString*)supplementaryViewReuseId;
-(Class)supplementaryViewClass;

@end
