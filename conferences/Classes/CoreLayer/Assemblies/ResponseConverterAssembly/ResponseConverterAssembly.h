//
//  ResponseConverterAssembly.h
//  Conferences
//
//  Created by k.zinovyev on 15.08.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import "ModuleAssemblyBase.h"
#import "AssemblyCollector/RamblerInitialAssembly.h"
#import "ResponseConverter.h"
#import "ResponseConverterFactory.h"

@interface ResponseConverterAssembly : ModuleAssemblyBase <ResponseConverterFactory, RamblerInitialAssembly>

-(id<ResponseConverter>)converterResponse;

@end
