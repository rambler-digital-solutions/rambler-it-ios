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

#import <Foundation/Foundation.h>

#import "RequestConfigurationType.h"
#import "RequestSigningType.h"
#import "NetworkConnectionType.h"
#import "ResponseDeserializationType.h"
#import "ResponseValidationType.h"
#import "ResponseMappingType.h"

typedef id(^CompoundOperationInputDataMappingBlock)(id data);

/**
 @author Egor Tolstoy
 
 The config is used by NetworkCompoundOperationBuilder to build a proper compound operation
 */
@interface CompoundOperationBuilderConfig : NSObject

// General parameters
@property (nonatomic, strong) id inputQueueData;
@property (nonatomic, copy) CompoundOperationInputDataMappingBlock inputDataMappingBlock;

// Request configuration operation parameters
@property (nonatomic, assign) RequestConfigurationType requestConfigurationType;
@property (nonatomic, assign) NSString *requestMethod;
@property (nonatomic, assign) NSString *serviceName;
@property (nonatomic, strong) NSArray *urlParameters;

// Request signing operation parameters
@property (nonatomic, assign) RequestSigningType requestSigningType;

// Response deserialization operation parameters
@property (nonatomic, assign) ResponseDeserializationType responseDeserializationType;

// Validation operation parameters
@property (nonatomic, assign) ResponseValidationType responseValidationType;

// Mapping operation type
@property (nonatomic, assign) ResponseMappingType responseMappingType;
@property (nonatomic, strong) NSDictionary *mappingContext;

@end
