//
//  SpotlightEntityImageIndexer.h
//  Conferences
//
//  Created by Konstantin Zinovyev on 11.12.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

@class SpotlightImageModel;

/**
 @author Konstantin Zinovyev
 
 Responsible for indexing image of specific class
 */
@protocol SpotlightEntityImageIndexer <NSObject>

/**
 @author Konstantin Zinovyev
 
 Collects all image urls of specific class
 */
- (NSArray<SpotlightImageModel *> *)obtainImageModels;

/**
 @author Konstantin Zinovyev
 
 Update model object of specific class with imageURL
 */
- (void)updateModelsForEntityIdentifier:(NSString *)identifier;

@end
