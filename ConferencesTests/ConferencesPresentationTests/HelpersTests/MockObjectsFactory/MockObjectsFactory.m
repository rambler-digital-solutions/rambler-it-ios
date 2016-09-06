//
//  MockObjectsFactory.m
//  LiveJournal
//
//  Created by Egor Tolstoy on 15/10/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import "MockObjectsFactory.h"
#import "TagPlainObject.h"
#import <OCMock/OCMock.h>

@implementation MockObjectsFactory

+ (NSError *)generateGeneralError {
    NSError *error = [NSError errorWithDomain:@"TestDomain" code:0 userInfo:nil];
    return error;
}

+ (NSURLRequest *)generateGeneralURLRequest {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://rambler.ru"]];
    return request;
}

+ (NSArray *)generateGeneralArray {
    return @[@"1", @"2", @"3"];
}

+ (UITableView *)mockTableViewWithStubCellClass:(Class)cellClass
                                  forIdentifier:(NSString *)identifier {
    UITableView *testTableView = [UITableView new];
    id mockTableView = OCMPartialMock(testTableView);
    
    id mockCell = [cellClass new];
    OCMStub([mockTableView dequeueReusableCellWithIdentifier:identifier]).andReturn(mockCell);
    
    return mockTableView;
}

+ (UICollectionView *)mockCollectionViewViewWithMockCell:(id)mockCell
                                           forIdentifier:(NSString *)identifier {
    id mockCollectionView = OCMClassMock([UICollectionView class]);

    OCMStub([mockCollectionView dequeueReusableCellWithReuseIdentifier:identifier
                                                          forIndexPath:OCMOCK_ANY]).andReturn(mockCell);

    return mockCollectionView;
}

+ (UITableView *)mockTableViewWithStubCellClasses:(NSArray *)cellClasses
                                  forIdentifiers:(NSArray *)identifiers {
    UITableView *testTableView = [UITableView new];
    id mockTableView = OCMPartialMock(testTableView);
    
    [cellClasses enumerateObjectsUsingBlock:^(NSString *cellClassString, NSUInteger idx, BOOL * _Nonnull stop) {
        Class cellClass = NSClassFromString(cellClassString);
        NSString *identifier = identifiers[idx];
        id mockCell = [cellClass new];
        OCMStub([mockTableView dequeueReusableCellWithIdentifier:identifier]).andReturn(mockCell);
    }];
    
    return mockTableView;
}

+ (NewPostViewModel *)generateNewPostViewModel {
    NewPostViewModel *post = [self generateNewPostViewModelWithMediaItems:1];
    return post;
}

@end
