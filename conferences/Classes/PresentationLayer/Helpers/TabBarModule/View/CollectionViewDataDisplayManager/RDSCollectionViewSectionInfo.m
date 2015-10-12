//
//  RDSCollectionViewSectionInfo.m
//  Championat
//
//  Created by Andrey Zarembo-Godzyatsky on 15/07/15.
//  Copyright (c) 2015 Rambler DS. All rights reserved.
//

#import "RDSCollectionViewSectionInfo.h"

@interface RDSCollectionViewSectionInfo ()

@property (nonatomic,strong) id<RDSCollectionViewSupplementaryViewObjectProtocol> headerObject;
@property (nonatomic,strong) id<RDSCollectionViewSupplementaryViewObjectProtocol> footerObject;
@property (nonatomic,strong) NSArray* cellObjects;

@end

@implementation RDSCollectionViewSectionInfo

- (instancetype)initWithHeaderObject:(id<RDSCollectionViewSupplementaryViewObjectProtocol>)headerObject
                        footerObject:(id<RDSCollectionViewSupplementaryViewObjectProtocol>)footerObject
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
