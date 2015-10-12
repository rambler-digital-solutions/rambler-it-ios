//
//  RDSCollectionViewSupplementaryViewObject.m
//  Championat
//
//  Created by Andrey Zarembo-Godzyatsky on 15/07/15.
//  Copyright (c) 2015 Rambler DS. All rights reserved.
//

#import "RDSCollectionViewSupplementaryViewObject.h"

@implementation RDSCollectionViewSupplementaryViewObject

-(NSString*)supplementaryViewReuseId {
    return NSStringFromClass([self supplementaryViewClass]);
}

- (Class)supplementaryViewClass {
    return nil;
}

@end
