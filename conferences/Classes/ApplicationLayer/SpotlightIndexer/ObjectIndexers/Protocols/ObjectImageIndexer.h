//
//  ObjectImageIndexer.h
//  Conferences
//
//  Created by Konstantin Zinovyev on 11.12.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

/**
 @author Konstantin Zinovyev
 
 Responsible for indexing image of specific class
 */
@protocol ObjectImageIndexer <NSObject>

/**
 @author Konstantin Zinovyev
 
 Collects all image urls of specific class
 */
- (NSArray<NSURL *> *)obtainImageURLs;

/**
 @author Konstantin Zinovyev
 
 Update model object of specific class with imageURL
 */
- (void)updateModelsForImageURL:(NSURL *)imageURL;

@end
