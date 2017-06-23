//
//  RamblerTyphoonAssemblyTestsTypeDescriptor.h
//  RamblerTyphoonUtils
//
//  Created by Aleksandr Sychev on 10.01.16.
//  Copyright © 2016 Egor Tolstoy. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 @author Aleksandr Sychev
 
 Class describes testing types of target object or dependencies
 
 @note We don't verify blocks and primitive types
 */
@interface RamblerTyphoonAssemblyTestsTypeDescriptor : NSObject

+ (instancetype)descriptorWithClass:(Class)describedClass;
- (instancetype)initWithClass:(Class)describedClass;
+ (instancetype)descriptorWithProtocols:(NSArray *)conformingProtocols;
- (instancetype)initWithProtocols:(NSArray *)conformingProtocols;
+ (instancetype)descriptorWithClass:(Class)describedClass
                       andProtocols:(NSArray *)conformingProtocols;
- (instancetype)initWithClass:(Class)describedClass
                 andProtocols:(NSArray *)conformingProtocols;

/**
 @author Aleksandr Sychev
 
 Type being described
 
 @note defaultValue is [NSObject class]
 */
@property (nonatomic, assign) Class describedClass;

/**
 @author Aleksandr Sychev
 
 An array of protocols, which type conforms to
 */
@property (nonatomic, copy) NSArray *conformingProtocols;

@end
