// Copyright (c) 2015 RAMBLER&Co
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

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

+ (NSNumber *)generateRandomNumber {
    return @5;
}

@end
