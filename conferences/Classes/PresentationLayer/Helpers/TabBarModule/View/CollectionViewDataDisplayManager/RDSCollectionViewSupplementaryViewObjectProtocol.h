//
//  RDSCollectionViewSupplementaryViewObjectProtocol.h
//  Championat
//
//  Created by Andrey Zarembo-Godzyatsky on 15/07/15.
//  Copyright (c) 2015 Rambler DS. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RDSCollectionViewSupplementaryViewObjectProtocol <NSObject>

-(NSString*)supplementaryViewReuseId;
-(Class)supplementaryViewClass;

@end
