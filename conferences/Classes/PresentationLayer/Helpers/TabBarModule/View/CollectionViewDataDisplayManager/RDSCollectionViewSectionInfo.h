//
//  RDSCollectionViewSectionInfo.h
//  Championat
//
//  Created by Andrey Zarembo-Godzyatsky on 15/07/15.
//  Copyright (c) 2015 Rambler DS. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RDSCollectionViewSupplementaryViewObjectProtocol;

@interface RDSCollectionViewSectionInfo : NSObject

@property (nonatomic,strong,readonly) id<RDSCollectionViewSupplementaryViewObjectProtocol> headerObject;
@property (nonatomic,strong,readonly) id<RDSCollectionViewSupplementaryViewObjectProtocol> footerObject;
@property (nonatomic,strong,readonly) NSArray* cellObjects;

- (instancetype)initWithHeaderObject:(id<RDSCollectionViewSupplementaryViewObjectProtocol>)headerObject
                        footerObject:(id<RDSCollectionViewSupplementaryViewObjectProtocol>)footerObject
              andFlatListCellObjects:(NSArray*)cellObjects;

@end
