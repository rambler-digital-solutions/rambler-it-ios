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

#import "TyphoonAssembly.h"
#import <RamblerTyphoonUtils/AssemblyCollector.h>

@protocol RequestConfiguratorsFactory;
@protocol RequestSignersFactory;
@protocol NetworkClientsFactory;
@protocol ResponseDeserializersFactory;
@protocol ResponseValidatorsFactory;
@protocol ResponseMappersFactory;
@protocol ResponseConverterFactory;

@class EventOperationFactory;

/**
 @author Egor Tolstoy
 
 A TyphoonAssembly which is responsible for creating operation factories for different services
 */
@interface OperationFactoriesAssembly : TyphoonAssembly <RamblerInitialAssembly>

- (EventOperationFactory *)eventListOperationFactory;

@property (nonatomic, strong, readonly) TyphoonAssembly <RequestConfiguratorsFactory> *requestConfiguratorsFactory;
@property (nonatomic, strong, readonly) TyphoonAssembly <RequestSignersFactory> *requestSignersFactory;
@property (nonatomic, strong, readonly) TyphoonAssembly <NetworkClientsFactory> *networkClientsFactory;
@property (nonatomic, strong, readonly) TyphoonAssembly <ResponseDeserializersFactory> *responseDeserializersFactory;
@property (nonatomic, strong, readonly) TyphoonAssembly <ResponseValidatorsFactory> *responseValidatorsFactory;
@property (nonatomic, strong, readonly) TyphoonAssembly <ResponseMappersFactory> *responseMappersFactory;
@property (nonatomic, strong, readonly) TyphoonAssembly <ResponseConverterFactory> *responseConverterFactory;

@end
