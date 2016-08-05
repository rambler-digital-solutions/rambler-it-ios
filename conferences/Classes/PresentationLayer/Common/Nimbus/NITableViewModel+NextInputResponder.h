//
//  NITableViewModel+NextInputResponder.h
//  LiveJournal
//
//  Created by Vasyura Anastasiya on 03/12/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import <NITableViewModel.h>

@interface NITableViewModel (NextInputResponder)

- (NSIndexPath *)nextInputResponderIndexPathForIndexPath:(NSIndexPath *)indexPath;

@end
