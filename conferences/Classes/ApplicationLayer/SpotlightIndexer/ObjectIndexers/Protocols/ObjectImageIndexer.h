//
//  ObjectImageIndexer.h
//  Conferences
//
//  Created by Konstantin Zinovyev on 11.12.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

@protocol ObjectImageIndexer <NSObject>

- (NSArray<NSURL *> *)obtainImageURLs;
- (void)updateModelsForImageURL:(NSURL *)imageURL;

@end
