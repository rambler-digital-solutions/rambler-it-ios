//
//  ServerResponseModel.m
//  LiveJournal
//
//  Created by Egor Tolstoy on 12/02/16.
//  Copyright © 2016 Rambler&Co. All rights reserved.
//

#import "ServerResponseModel.h"

@interface ServerResponseModel ()

@property (nonatomic, strong, readwrite) NSHTTPURLResponse *response;
@property (nonatomic, strong, readwrite) NSData *data;

@end

@implementation ServerResponseModel

- (instancetype)initWithResponse:(NSHTTPURLResponse *)response
                            data:(NSData *)data {
    self = [super init];
    if (self) {
        _response = response;
        _data = data;
    }
    return self;
}

@end
